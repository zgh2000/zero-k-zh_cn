# Verify how i18n.load processes chililobby.lua
import zipfile, re

z = zipfile.ZipFile(r'D:\SteamLibrary\steamapps\common\Zero-K\games\zkmenu-stable.sdz', 'r')
content = z.read('luamenu/widgets/chobby/i18n/chililobby.lua').decode('utf-8').replace('\r', '')
lines = content.split('\n')

# Find section boundaries properly
sections = {}
current = None
for i, line in enumerate(lines):
    stripped = line.strip()
    # Detect top-level locale sections (1 tab indent)
    for loc in ['en', 'de', 'it', 'sr', 'jp', 'zh_CN', 'es']:
        if line == '\t' + loc + ' = {':
            current = loc
            sections[loc] = {'start': i, 'end': None, 'keys': []}
    # Detect section end (1-tab closing brace)
    if current and line.startswith('\t') and not line.startswith('\t\t'):
        if stripped == '},' or stripped == '}':
            if sections.get(current) and sections[current]['end'] is None:
                sections[current]['end'] = i
                current = None

# Extract keys from each section
for loc, info in sections.items():
    if info['end'] is None:
        continue
    for i in range(info['start']+1, info['end']):
        line = lines[i]
        # Match regular keys (2-tab indent)
        m = re.match(r'^\t\t([a-zA-Z_]\w*)\s*=', line)
        if m:
            info['keys'].append(m.group(1))
        # Match bracket keys
        m = re.match(r'^\t\t\["([^"]+)"\]\s*=', line)
        if m:
            info['keys'].append(m.group(1))

# Report
for loc in ['en', 'zh_CN', 'es']:
    if loc in sections:
        s = sections[loc]
        print(f'{loc}: lines {s["start"]+1}-{s["end"]+1}, keys: {len(s["keys"])}, unique: {len(set(s["keys"]))}')

# Find keys in en but not zh_CN
if 'en' in sections and 'zh_CN' in sections:
    en_set = set(sections['en']['keys'])
    zh_set = set(sections['zh_CN']['keys'])
    missing = en_set - zh_set
    print(f'\nKeys in en but NOT in zh_CN: {len(missing)}')
    for k in sorted(list(missing))[:30]:
        print(f'  {k}')
    if len(missing) > 30:
        print(f'  ... and {len(missing)-30} more')

# Check es section for Chinese content
if 'es' in sections:
    es_keys = set(sections['es']['keys'])
    en_set = set(sections['en']['keys'])
    zh_set = set(sections['zh_CN']['keys'])
    misplaced = es_keys & zh_set
    es_only = es_keys - en_set - zh_set
    print(f'\nKeys in es that also exist in zh_CN (misplaced?): {len(misplaced)}')
    for k in sorted(list(misplaced)):
        print(f'  {k}')