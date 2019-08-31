-- console.log(memory.getmemorydomainlist())
-- "0": "CARTRAM"
-- "1": "WRAM"
-- "2": "VRAM"
-- "3": "CARTROM"

--mainmemory.read_u8(0x0082); -- 00
--mainmemory.read_u8(0x0084); -- movement related?
--mainmemory.read_u8(0x0086); -- X tile position of Link % 0x20
--mainmemory.read_u8(0x0088); -- Y tile position of Link % 0x20

local xoffs, yoffs;
local screen, dungeon;
local y = {};
local x = {};
local t = {};

while true do
    screen = mainmemory.read_u16_le(0x008A);
    dungeon = mainmemory.read_u16_le(0x00A0);

    yoffs = mainmemory.read_s16_le(0x00E8);
    xoffs = mainmemory.read_s16_le(0x00E2);

    gui.drawText(0, 0, string.format("%04x %04x  x=%04x,y=%04x", screen, dungeon, xoffs, yoffs));

    for i = 1, 16 do
        y[i] = bit.bor(mainmemory.read_u8(0x0D00+i-1), bit.lshift(mainmemory.read_u8(0x0D20+i-1), 8));
        x[i] = bit.bor(mainmemory.read_u8(0x0D10+i-1), bit.lshift(mainmemory.read_u8(0x0D30+i-1), 8));
        t[i] = mainmemory.read_u8(0x0E20+i-1);

        if t[i] ~= 0 then
            gui.drawText(x[i]-xoffs, y[i]-yoffs, string.format("%02x", t[i]));
            gui.drawText(x[i]-xoffs+4, y[i]-yoffs-10, string.format("%x", i-1), null, null, 10);
        end
    end

    emu.frameadvance();
end