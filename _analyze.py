import re, collections

with open("work/chililobby.lua", "r", encoding="utf-8") as f:
    content = f.read()

lines = content.split("\n")
print("Total lines:", len(lines))

# Parse en section (lines 3 to ~358) and zh_CN section (lines 910 to ~1236)
en_keys = []
zh_keys = []
es_keys = []

in_section = None
brace_depth = 0

for i, line in enumerate(lines):
    s = line.strip()
    
    # Detect section starts (top-level only, indent = 1 tab)
    if line.startswith("\ten = {") or line.startswith("\ten = {"):
        in_section = "en"
        continue
    elif line.startswith("\tzh_CN = {"):
        in_section = "zh_CN"
        continue
    elif line.startswith("\tes = {"):
        in_section = "es"
        continue
    elif line.startswith("\tde = {"):
        in_section = "de"
        continue
    elif line.startswith("\tit = {"):
        in_section = "it"
        continue
    
    # Detect section end (single tab + closing brace)
    if in_section and line.startswith("\t") and not line.startswith("\t\t"):
        if s == "}," or s == "},":
            in_section = None
            continue
    
    if in_section is None:
        continue
    
    # Extract keys (2-tab indent = direct child)
    key_match = re.match(r'^\t\t([a-zA-Z_]\w*)\s*=', line)
    bracket_match = re.match(r'^\t\t\["([^"]+)"\]\s*=', line)
    
    key = None
    if bracket_match:
        key = bracket_match.group(1)
    elif key_match:
        key = key_match.group(1)
    
    if key:
        if in_section == "en":
            en_keys.append(key)
        elif in_section == "zh_CN":
            zh_keys.append(key)
        elif in_section == "es":
            es_keys.append(key)

# Analyze
en_set = set(en_keys)
zh_set = set(zh_keys)
es_set = set(es_keys)

print("\nen keys count:", len(en_keys), "unique:", len(en_set))
print("zh_CN keys count:", len(zh_keys), "unique:", len(zh_set))
print("es keys count:", len(es_keys), "unique:", len(es_set))

# Duplicates in en
c = collections.Counter(en_keys)
dupes = {k:v for k,v in c.items() if v > 1}
print("\nen section DUPLICATE keys:")
for k,v in sorted(dupes.items()):
    print(f"  {k}: {v} times")

# Keys in zh_CN but NOT in en
zh_only = zh_set - en_set
print("\nKeys in zh_CN but NOT in en (extra zh_CN keys):")
for k in sorted(zh_only):
    print(f"  {k}")

# Keys in es that look like Chinese
print("\nKeys in es section (checking for misplaced zh_CN):")
for k in sorted(es_set):
    if k not in en_set:
        print(f"  {k} (NOT in en - likely misplaced!)")

# Keys in en but NOT in zh_CN
missing = en_set - zh_set
print("\nKeys in en but NOT in zh_CN:")
for k in sorted(missing):
    print(f"  {k}")