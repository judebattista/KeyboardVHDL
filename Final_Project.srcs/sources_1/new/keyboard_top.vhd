library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.vga_components.ALL;

entity keyboard_top is
  Port (
        CLK100MHZ : in STD_LOGIC;
        PS2_CLK : in STD_LOGIC;
        PS2_DATA : in STD_LOGIC;
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        LED : out STD_LOGIC_VECTOR(7 downto 0);
        CT : out STD_LOGIC_VECTOR(6 downto 0);
        DP : out STD_LOGIC;
        AN : out STD_LOGIC_VECTOR(3 downto 0)
        );
end keyboard_top;

architecture keyboard_top of keyboard_top is
signal pclk, clk25, clk190, clr: STD_LOGIC;
signal xkey: STD_LOGIC_VECTOR(15 downto 0);
signal keyval1, keyval2, keyval3: STD_LOGIC_VECTOR(7 downto 0);
begin
    xkey <= keyval1 & keyval2;
    led <= keyval3;
    clr <= btn(3);
    
U1 : clkdiv2
    port map(mclk => CLK100MHZ, clr => clr, clk25 => clk25, clk190 => clk190);
    
U2 : keyboard_ctrl
    port map(
        clk25 => clk25,
            clr => clr,
            PS2C => PS2_CLK,
            PS2D => PS2_DATA,
            keyval1 => keyval1,
            keyval2 => keyval2,
            keyval3 => keyval3
    );

U3 : x7segbc
    port map( x => xkey, cclk => clk190, clr => clr, a_to_g => ct, an => an, dp => dp);

end keyboard_top;
