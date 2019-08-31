-- console.log(memory.getmemorydomainlist())
-- "0": "CARTRAM"
-- "1": "WRAM"
-- "2": "VRAM"
-- "3": "CARTROM"

local xoffs, yoffs;
local y = {};
local x = {};
local t = {};

while true do
    --yoffs = mainmemory.read_s16_le(0x0122);
    --xoffs = mainmemory.read_s16_le(0x011E);

    yoffs = mainmemory.read_s16_le(0x0E8);
    xoffs = mainmemory.read_s16_le(0x0E2);

    for i = 1, 16 do
        y[i] = bit.bor(mainmemory.read_u8(0x0D00+i-1), bit.lshift(mainmemory.read_u8(0x0D20+i-1), 8));
        x[i] = bit.bor(mainmemory.read_u8(0x0D10+i-1), bit.lshift(mainmemory.read_u8(0x0D30+i-1), 8));
        t[i] = mainmemory.read_u8(0x0E20+i-1);

        if t[i] ~= 0 then
            gui.drawText(x[i]-xoffs, y[i]-yoffs, string.format("%02x", t[i]));
        end
    end


	emu.frameadvance();
end