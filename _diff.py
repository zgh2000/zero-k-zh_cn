import zipfile

z = zipfile.ZipFile(r'D:\SteamLibrary\steamapps\common\Zero-K\games\zkmenu-stable.sdz', 'r')
sdz = z.read('luamenu/widgets/chobby/i18n/chililobby.lua').decode('utf-8')
work = open(r'D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\work\chililobby.lua', 'r', encoding='utf-8').read()

sl = sdz.split('\n')
wl = work.split('\n')

diffs = 0
for i in range(min(len(sl), len(wl))):
    if sl[i] != wl[i]:
        diffs += 1
        print(f'Line {i+1}:')
        print(f'  SDZ: {repr(sl[i][:80])}')
        print(f'  WRK: {repr(wl[i][:80])}')
        if diffs >= 15:
            break

if len(sl) != len(wl):
    print(f'Line count differs: SDZ={len(sl)}, Work={len(wl)}')

print(f'Total differences found: {diffs} (up to 15 shown)')