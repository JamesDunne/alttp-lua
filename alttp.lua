-- console.log(memory.getmemorydomainlist())
-- "0": "CARTRAM"
-- "1": "WRAM"
-- "2": "VRAM"
-- "3": "CARTROM"

--mainmemory.read_u8(0x0082); -- 00
--mainmemory.read_u8(0x0084); -- movement related?
--mainmemory.read_u8(0x0086); -- X tile position of Link % 0x20
--mainmemory.read_u8(0x0088); -- Y tile position of Link % 0x20

local y = {};
local x = {};
local t = {};
local state = {};

while true do
    local in_dark_world = mainmemory.read_u8(0x0FFF);
    local in_dungeon = mainmemory.read_u8(0x001B);
    local screen = mainmemory.read_u16_le(0x008A);
    local dungeon = mainmemory.read_u16_le(0x00A0);

    local screen_jsd = in_dark_world * 0x20000 + in_dungeon * 0x10000;
    if in_dungeon ~= 0 then
        screen_jsd = screen_jsd + dungeon;
    else
        screen_jsd = screen_jsd + screen;
    end

    local yoffs = mainmemory.read_s16_le(0x00E8);
    local xoffs = mainmemory.read_s16_le(0x00E2);

    gui.drawText(0, 0, string.format("%06x  x=%04x,y=%04x", screen_jsd, xoffs, yoffs), null, 0x3F000000, 11);

    for i = 1, 16 do
        y[i] = bit.bor(mainmemory.read_u8(0x0D00+i-1), bit.lshift(mainmemory.read_u8(0x0D20+i-1), 8));
        x[i] = bit.bor(mainmemory.read_u8(0x0D10+i-1), bit.lshift(mainmemory.read_u8(0x0D30+i-1), 8));
        state[i] = mainmemory.read_u8(0x0DD0+i-1);
        t[i] = mainmemory.read_u8(0x0E20+i-1);

        if t[i] ~= 0 and state[i] ~= 0 then
            gui.drawText(x[i]-xoffs, y[i]-yoffs, string.format("%02x", t[i]), null, 0x3F000000, 11);
            gui.drawText(x[i]-xoffs+3, y[i]-yoffs-10, string.format("%x", i-1), null, 0x3F000000, 11);
        end
    end

    emu.frameadvance();
end