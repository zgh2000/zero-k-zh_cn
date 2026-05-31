"""
生成原文与翻译对照表格 (Markdown)
从 .sdz 提取英文原文，与 campaign_zh_CN.lua 和 JSON 文件中的翻译做对照
"""
import zipfile, json, re
from pathlib import Path
from collections import OrderedDict

GAMES_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\games")
WORK_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\work")
OUTPUT = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\translation_diff.md")


def extract_planets_en():
    """从 .sdz 提取所有星球英文原文"""
    sdz = GAMES_DIR / "zkmenu-stable.sdz"
    planets = OrderedDict()
    with zipfile.ZipFile(sdz, 'r') as z:
        planet_files = sorted(
            [n for n in z.namelist()
             if re.match(r'campaign/sample/planets/planet\d+\.lua$', n)],
            key=lambda n: int(re.search(r'planet(\d+)', n).group(1))
        )
        for arcname in planet_files:
            data = z.read(arcname).decode('utf-8')
            planet = {}
            m = re.search(r'name\s*=\s*"([^"]+)"', data)
            if not m:
                continue
            planet['name'] = m.group(1)

            m = re.search(r'hintText\s*=\s*"([^"]*)"', data)
            if m:
                planet['hintText'] = m.group(1)

            m = re.search(r'terrainType\s*=\s*"([^"]+)"', data)
            if m:
                planet['terrainType'] = m.group(1)

            m = re.search(r'primary\s*=\s*"([^"]+)"', data)
            if m:
                planet['primary'] = m.group(1)
            m = re.search(r'primaryType\s*=\s*"([^"]+)"', data)
            if m:
                planet['primaryType'] = m.group(1)

            def extract_lua_string(source, field_name):
                """Extract a Lua string field that may be plain or concatenated with .."""
                # Try concatenated form first (multiline): field = "a" .. "\n " .. "b"
                concat_pat = (field_name + r'\s*=\s*((?:"[^"]*"\s*\.\.\s*)+'
                              r'"(?:[^"\\]|\\.)*")')
                m = re.search(concat_pat, source, re.DOTALL)
                if m:
                    raw = m.group(1)
                    parts = re.findall(r'"((?:[^"\\]|\\.)*)"', raw)
                    return ' '.join(re.sub(r'\\n', ' ', p) for p in parts).strip()
                # Try plain string: field = "some text"
                plain_pat = field_name + r'\s*=\s*"((?:[^"\\]|\\.)*)"'
                m = re.search(plain_pat, source)
                if m:
                    return m.group(1).replace('\\n', ' ').strip()
                return ''

            planet['text'] = extract_lua_string(data, 'text')
            planet['extendedText'] = extract_lua_string(data, 'extendedText')

            objectives = []
            for om in re.finditer(r'description\s*=\s*"([^"]+)"', data):
                objectives.append(om.group(1))
            if objectives:
                planet['objectives'] = objectives

            planets[planet['name']] = planet
    return planets


def extract_codex_en():
    """从 .sdz 提取所有百科英文原文"""
    sdz = GAMES_DIR / "zkmenu-stable.sdz"
    with zipfile.ZipFile(sdz, 'r') as z:
        data = z.read("campaign/sample/codex.lua").decode('utf-8')

    entries = OrderedDict()
    for m in re.finditer(
        r'(\w+)\s*=\s*\{[^}]*?name\s*=\s*"([^"]+)"[^}]*?'
        r'category\s*=\s*"([^"]+)"[^}]*?'
        r'text\s*=\s*\[\[(.*?)\]\]',
        data, re.DOTALL
    ):
        eid = m.group(1)
        entries[eid] = {
            'name': m.group(2),
            'category': m.group(3),
            'text': m.group(4).strip(),
        }
    return entries


def parse_lua_section(content, section_name):
    """提取 content 中 T.section_name = { ... } 的块"""
    pattern = rf'\.{section_name}\s*=\s*\{{'
    m = re.search(pattern, content)
    if not m:
        return None
    start = m.end()
    depth = 1
    i = start
    while i < len(content) and depth > 0:
        if content[i] == '{':
            depth += 1
        elif content[i] == '}':
            depth -= 1
        i += 1
    return content[start:i-1]


def parse_campaign_zh_cn():
    """解析 campaign_zh_CN.lua 翻译数据库"""
    path = WORK_DIR / "campaign_zh_CN.lua"
    raw = path.read_bytes()
    if raw[:3] == b'\xef\xbb\xbf':
        raw = raw[3:]
    content = raw.decode('utf-8').replace('\r\n', '\n').replace('\r', '\n')

    result = {}

    # Planets
    result['planets'] = OrderedDict()
    planet_section = parse_lua_section(content, 'planets')
    if planet_section:
        for m in re.finditer(r'\["([^"]+)"\]\s*=\s*\{', planet_section):
            pname = m.group(1)
            block_start = m.end()
            depth = 1
            i = block_start
            while i < len(planet_section) and depth > 0:
                if planet_section[i] == '{':
                    depth += 1
                elif planet_section[i] == '}':
                    depth -= 1
                i += 1
            block = planet_section[block_start-1:i+1]

            entry = {}
            m2 = re.search(r'hintText\s*=\s*"([^"]*)"', block)
            if m2:
                entry['hintText'] = m2.group(1)
            m2 = re.search(r'text\s*=\s*\[\[(.*?)\]\]', block, re.DOTALL)
            if m2:
                entry['text'] = m2.group(1).strip()
            m2 = re.search(r'extendedText\s*=\s*\[\[(.*?)\]\]', block, re.DOTALL)
            if m2:
                entry['extendedText'] = m2.group(1).strip()
            obj_match = re.search(r'objectives\s*=\s*\{([^}]+)\}', block)
            if obj_match:
                entry['objectives'] = re.findall(r'"([^"]+)"', obj_match.group(1))
            result['planets'][pname] = entry

    # Codex
    result['codex'] = OrderedDict()
    codex_section = parse_lua_section(content, 'codex')
    if codex_section:
        for m in re.finditer(r'\["([^"]+)"\]\s*=\s*\{', codex_section):
            eid = m.group(1)
            block_start = m.end()
            depth = 1
            i = block_start
            while i < len(codex_section) and depth > 0:
                if codex_section[i] == '{':
                    depth += 1
                elif codex_section[i] == '}':
                    depth -= 1
                i += 1
            block = codex_section[block_start-1:i+1]

            entry = {}
            m2 = re.search(r'name\s*=\s*"([^"]*)"', block)
            if m2:
                entry['name'] = m2.group(1)
            m2 = re.search(r'text\s*=\s*\[\[(.*?)\]\]', block, re.DOTALL)
            if m2:
                entry['text'] = m2.group(1).strip()
            result['codex'][eid] = entry

    # Simple tables: codex_categories, common, terrain_types
    for key in ('codex_categories', 'common', 'terrain_types'):
        tbl = OrderedDict()
        section = parse_lua_section(content, key)
        if section:
            for m in re.finditer(r'(?:\["([^"]+)"\]|(\w+))\s*=\s*"([^"]+)"', section):
                k = m.group(1) or m.group(2)
                tbl[k] = m.group(3)
        result[key] = tbl

    return result


def load_json_translations():
    """加载所有 JSON 翻译文件"""
    jsons = OrderedDict()
    for fname in ('common.zh_cn.json', 'epicmenu.zh_cn.json', 'healthbars.zh_cn.json',
                   'interface.zh_cn.json', 'units.zh_cn.json'):
        fpath = WORK_DIR / fname
        if fpath.exists():
            with open(fpath, 'r', encoding='utf-8') as f:
                jsons[fname] = json.load(f)
    return jsons


def clean_text(text, max_len=100):
    """截断长文本用于表格显示"""
    text = text.replace('\n', ' ').replace('|', '\\|')
    text = re.sub(r'\s+', ' ', text).strip()
    if len(text) > max_len:
        text = text[:max_len-3] + '...'
    return text


def generate():
    print("Extracting English planets from .sdz...")
    planets_en = extract_planets_en()
    print(f"  {len(planets_en)} planets")

    print("Extracting English codex from .sdz...")
    codex_en = extract_codex_en()
    print(f"  {len(codex_en)} codex entries")

    print("Parsing campaign_zh_CN.lua...")
    zh = parse_campaign_zh_cn()
    print(f"  {len(zh['planets'])} planets, {len(zh['codex'])} codex entries, "
          f"{len(zh['codex_categories'])} categories, {len(zh['common'])} common, "
          f"{len(zh['terrain_types'])} terrain types")

    print("Loading JSON translations...")
    jsons = load_json_translations()
    for name, data in jsons.items():
        print(f"  {name}: {len(data)} entries")

    lines = []

    def w(s=''):
        lines.append(s)

    w('# Zero-K 简体中文汉化 — 原文与翻译对照表')
    w()
    total = (len(planets_en) + len(codex_en)
             + len(zh['codex_categories']) + len(zh['common']) + len(zh['terrain_types'])
             + sum(len(d) for d in jsons.values()))
    w(f'> 共 {len(planets_en)} 星球 + {len(codex_en)} 百科条目 + '
      f'{len(zh["codex_categories"]) + len(zh["common"]) + len(zh["terrain_types"])} 简单键 '
      f'+ {sum(len(d) for d in jsons.values())} JSON 键')
    w()

    # ---- Planets ----
    w('## 一、星球描述')
    w()
    w('| 星球 | 原文 (hintText) | 翻译 (hintText) | 原文 (text) | 翻译 (text) |')
    w('|------|-----------------|-----------------|-------------|-------------|')
    for name, en in planets_en.items():
        zh_planet = zh['planets'].get(name, {})
        w(f'| **{name}** | {clean_text(en.get("hintText", ""))} | '
          f'{clean_text(zh_planet.get("hintText", ""))} | '
          f'{clean_text(en.get("text", ""))} | {clean_text(zh_planet.get("text", ""))} |')

    w()
    w('### extendedText')
    w()
    w('| 星球 | 原文 (extendedText) | 翻译 (extendedText) |')
    w('|------|---------------------|---------------------|')
    for name, en in planets_en.items():
        zh_planet = zh['planets'].get(name, {})
        en_ext = clean_text(en.get('extendedText', ''))
        zh_ext = clean_text(zh_planet.get('extendedText', ''))
        if en_ext or zh_ext:
            w(f'| **{name}** | {en_ext} | {zh_ext} |')

    w()
    w('### 星球元数据')
    w()
    w('| 星球 | 主恒星 (EN) | 主恒星 (ZH) | 类型 (EN) | 类型 (ZH) | 地形 (EN) | 地形 (ZH) |')
    w('|------|------------|------------|----------|----------|----------|----------|')
    for name, en in planets_en.items():
        zh_planet = zh['planets'].get(name, {})
        w(f'| **{name}** | {en.get("primary", "")} | - | '
          f'{en.get("primaryType", "")} | - | '
          f'{en.get("terrainType", "")} | {zh["terrain_types"].get(en.get("terrainType", ""), "")} |')

    # ---- Codex ----
    w()
    w('## 二、百科条目')
    w()
    w('| ID | 分类 | 原文名称 | 翻译名称 |')
    w('|----|------|----------|----------|')
    for eid, en in codex_en.items():
        zh_entry = zh['codex'].get(eid, {})
        cat_en = en.get('category', '')
        cat_zh = zh['codex_categories'].get(cat_en, cat_en)
        w(f'| `{eid}` | {cat_zh} | {en["name"]} | {zh_entry.get("name", "")} |')

    # Missing entries
    missing_codex = set(zh['codex'].keys()) - set(codex_en.keys())
    if missing_codex:
        w()
        w(f'**翻译中有但 .sdz 中无对应**: {", ".join(sorted(missing_codex))}')

    w()
    w('### 百科正文对照 (前 150 字符)')
    w()
    w('| ID | 原文 | 翻译 |')
    w('|----|------|------|')
    for eid, en in codex_en.items():
        zh_entry = zh['codex'].get(eid, {})
        w(f'| `{eid}` | {clean_text(en["text"], 150)} | {clean_text(zh_entry.get("text", ""), 150)} |')

    # ---- Categories ----
    w()
    w('## 三、百科分类')
    w()
    w('| 原文 | 翻译 |')
    w('|------|------|')
    for en_val, zh_val in zh['codex_categories'].items():
        w(f'| {en_val} | {zh_val} |')

    # ---- Common ----
    w()
    w('## 四、通用标签')
    w()
    w('| 键 | 翻译 |')
    w('|----|------|')
    for key, zh_val in zh['common'].items():
        w(f'| `{key}` | {zh_val} |')

    # ---- Terrain ----
    w()
    w('## 五、地形类型')
    w()
    w('| 原文 | 翻译 |')
    w('|------|------|')
    for en_val, zh_val in zh['terrain_types'].items():
        w(f'| {en_val} | {zh_val} |')

    # ---- JSON ----
    w()
    w('## 六、JSON 翻译文件')
    for fname, data in jsons.items():
        w()
        w(f'### {fname} ({len(data)} 条)')
        w()
        w('| 原文 | 翻译 |')
        w('|------|------|')
        for key, zh_val in data.items():
            w(f'| {clean_text(key, 80)} | {clean_text(str(zh_val), 80)} |')

    output = '\n'.join(lines)
    OUTPUT.write_text(output, encoding='utf-8', newline='\n')
    print(f"\nDone: {OUTPUT}")
    print(f"  {len(lines)} lines, {len(output)} chars")

    # Save full (untruncated) cache for reverse conversion
    CACHE = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\translation_cache.json")
    cache = {
        'planets': {},
        'codex': {},
        'codex_categories': zh['codex_categories'],
        'common': zh['common'],
        'terrain_types': zh['terrain_types'],
        'json': {},
    }
    for name, en in planets_en.items():
        zh_planet = zh['planets'].get(name, {})
        cache['planets'][name] = {
            'hintText_en': en.get('hintText', ''),
            'hintText_zh': zh_planet.get('hintText', ''),
            'text_en': en.get('text', ''),
            'text_zh': zh_planet.get('text', ''),
            'extendedText_en': en.get('extendedText', ''),
            'extendedText_zh': zh_planet.get('extendedText', ''),
            'objectives_en': en.get('objectives', []),
            'objectives_zh': zh_planet.get('objectives', []),
        }
    for eid, en in codex_en.items():
        zh_entry = zh['codex'].get(eid, {})
        cache['codex'][eid] = {
            'name_en': en['name'],
            'name_zh': zh_entry.get('name', ''),
            'text_en': en['text'],
            'text_zh': zh_entry.get('text', ''),
            'category': en.get('category', ''),
        }
    for fname, data in jsons.items():
        cache['json'][fname] = dict(data)

    with open(CACHE, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(cache, f, ensure_ascii=False, indent=2)
        f.write('\n')
    print(f"Cache saved: {CACHE}")

if __name__ == '__main__':
    generate()
