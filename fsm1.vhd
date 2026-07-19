library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity fsm1 is
    port (
        clk, reset:   in STD_LOGIC;
        taken, back:  in STD_LOGIC;
        predicttaken: out STD_LOGIC
    );
end;

architecture synth of fsm1 is
    type statetype is (S0, S1, S2, S3, S4);
    signal state, nextstate: statetype;
begin
    -- State Register (Resets to S2)
    process (clk, reset) begin
        if reset = '1' then 
            state <= S2;
        elsif clk'event and clk = '1' then
            state <= nextstate;
        end if;
    end process;

    -- Next State Logic
    process (state, taken) begin
        case state is
            when S0 => 
                if taken = '1' then nextstate <= S1;
                else                nextstate <= S0;
                end if;
            when S1 => 
                if taken = '1' then nextstate <= S2;
                else                nextstate <= S0;
                end if;
            when S2 => 
                if taken = '1' then nextstate <= S3;
                else                nextstate <= S1;
                end if;
            when S3 => 
                if taken = '1' then nextstate <= S4;
                else                nextstate <= S2;
                end if;
            when S4 => 
                if taken = '1' then nextstate <= S4;
                else                nextstate <= S3;
                end if;
            when others => 
                nextstate <= S2;
        end case;
    end process;

    -- Output Logic
    predicttaken <= '1' when ((state = S4) or (state = S3) or (state = S2 and back = '1')) else '0';

end architecture;
