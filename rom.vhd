--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Mon Sep 26 00:57:06 2022
--Host        : Arda running 64-bit major release  (build 9200)
--Command     : generate_target rom.bd
--Design      : rom
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity rom is
  port (
    addra_0 : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clka_0 : in STD_LOGIC;
    douta_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ena_0 : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of rom : entity is "rom,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=rom,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of rom : entity is "rom.hwdef";
end rom;

architecture STRUCTURE of rom is
  component rom_blk_mem_gen_0_0 is
  port (
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 13 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component rom_blk_mem_gen_0_0;
  signal addra_0_1 : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal blk_mem_gen_0_douta : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal clka_0_1 : STD_LOGIC;
  signal ena_0_1 : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clka_0 : signal is "xilinx.com:signal:clock:1.0 CLK.CLKA_0 CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clka_0 : signal is "XIL_INTERFACENAME CLK.CLKA_0, CLK_DOMAIN rom_clka_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
begin
  addra_0_1(13 downto 0) <= addra_0(13 downto 0);
  clka_0_1 <= clka_0;
  douta_0(31 downto 0) <= blk_mem_gen_0_douta(31 downto 0);
  ena_0_1 <= ena_0;
blk_mem_gen_0: component rom_blk_mem_gen_0_0
     port map (
      addra(13 downto 0) => addra_0_1(13 downto 0),
      clka => clka_0_1,
      douta(31 downto 0) => blk_mem_gen_0_douta(31 downto 0),
      ena => ena_0_1
    );
end STRUCTURE;
