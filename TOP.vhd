library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DENE is
  Port (en, clk: in std_logic;
  tx: out std_logic;
  reset: inout std_logic 
  );
end DENE;

architecture Behavioral of DENE is


component rom_wrapper is
  port (
    sw : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clk : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    en : in STD_LOGIC
  );
  
  end component rom_wrapper;
signal stop: std_logic_vector(31 downto 0):="10101010010101010000001111001100";
signal start: std_logic_vector(31 downto 0):="01010101101010101100110000000011";
signal say: integer range 0 to 16386:=0;
signal dout: std_logic_vector(31 downto 0);
signal counter: integer range 0 to 389:= 0;
signal dortbit: integer range 0 to 3:=0;
type states is(hazir,dogrubyte,gonder,kontrol);
signal state: states:= hazir;
signal gidendata: std_logic_vector(9 downto 0);
signal txx: std_logic:='1';
signal hangibit: integer range 0 to 11:=0;
signal flag: std_logic;
signal adres:  std_logic_vector(13 downto 0); 

begin


sangane: component rom_wrapper
     port map (
      sw(13 downto 0) => adres (13 downto 0 ), 
      clk => clk,
      dout(31 downto 0) => dout(31 downto 0),
      en => en
    );





process(clk)
begin
if reset='1'  then
counter<=0;
tx<='1';
dortbit<=0;
hangibit<=0;
gidendata<="0000000000";
adres<="00000000000000";
say<=0;
flag<='0';
state<=hazir;



elsif rising_edge(clk) and flag='0'   and en='1' and reset= '0' then
    

    
    case state is
        when hazir  =>
        if reset='0' then
        if counter < 389 then 
        counter<= counter+1;
        state<= hazir;
        else
        state<= dogrubyte;
        end if;
        else
        counter<=0;
         hangibit<=0;
         state<=hazir;
         end if;

        
        when dogrubyte=>
        
       
            if counter=389 then
                if say=0 then
                    if dortbit=0 then
                    gidendata<=('1'& start(7 downto 0) & '0');
                    state<=gonder;
                elsif dortbit=1 then
                    gidendata<=('1'& start(15 downto 8) & '0');
                    state<=gonder;
                elsif dortbit=2 then
                    gidendata<=('1'& start(23 downto 16) & '0');
                    state<=gonder;
                    
                else
                   gidendata<=('1'& start(31 downto 24) & '0');
                    state<=gonder; 
                    
                 end if;
                    
                elsif say=16385 then 
                    if dortbit=0 then
                        gidendata<=('1'& stop(7 downto 0) & '0');
                        state<=gonder;
                    elsif dortbit=1 then
                        gidendata<=('1'& stop(15 downto 8) & '0');
                        state<=gonder;
                    elsif dortbit=2 then
                        gidendata<=('1'& stop(23 downto 16) & '0');
                        state<=gonder;
                    else
                        gidendata<=('1'& stop(31 downto 24) & '0');
                        state<=gonder; 
                        
                     end if;
                    
                else
                   if dortbit=0 then
                        gidendata<=('1'& dout(7 downto 0) & '0');
                        state<=gonder;
                    elsif dortbit=1 then
                        gidendata<=('1'& dout(15 downto 8) & '0');
                        state<=gonder;
                    elsif dortbit=2 then
                        gidendata<=('1'& dout(23 downto 16) & '0');
                        state<=gonder;
                    else
                        gidendata<=('1'& dout(31 downto 24) & '0');
                        state<=gonder; 
                        
                     end if;
                    
               end if;
             end if; 
             
             
             when gonder=>
                tx<=gidendata(hangibit);
                hangibit<=hangibit+1;   
                state<= kontrol;
         
                      
        
        
        
        
        
         when kontrol=>
            
                if hangibit<10 then
                counter<=0;
                 state<=hazir;
                
                else
                    if dortbit<3 then
                        dortbit<=dortbit+1;
                        hangibit<=0;
                        counter<=0;
                        state<= hazir;
                    else
                    
                        if say=0 then
                        dortbit<=0;
                        hangibit<=0;
                        counter<=0;
                        say<=say+1;
                        adres<=adres;
                        state<= hazir;
                        
                       
                        
                        elsif say=16385 then
                            dortbit<=0;
                            hangibit<=0;
                            counter<=0;
                            adres<="00000000000000";
                            say<=0;
                            flag<='1';
                            state<= hazir;
                            
                            
                       
                       
                        
                        else
                            dortbit<=0;
                            hangibit<=0;
                            counter<=0;
                            say<=say+1;
                            adres<=adres+1;
                            state<= hazir;
                        end if;
                        
                        
                        end if;
                  end if;

                           
            
        when others=> 
       state<= hazir;
        end case;
        end if;
        end process;
        

         
 
 

end Behavioral;
