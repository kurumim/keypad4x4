module keypad (
    input clk,
    output [3:0] col,
    input [3:0] row,
    output [3:0] keypressed,
    output active
);

reg enable = 0;

assign active = enable;

reg [3:0] rp;
reg [1:0] cp;

wire [1:0] t = rp  == 4'b0001 ? 2'b01 : rp == 4'b0010 ? 2'b10 : rp == 4'b0100 ? 2'b11 : rp == 4'b1000 ? 2'b00 : 2'b00; 


reg [3:0] status = 4'b0000;
assign col = status;
reg [3:0] counter = 4'b0000;

assign keypressed = {t,cp};

always @(posedge clk ) begin
    case (status)
        4'b0000: begin
            if (counter == 4'b1111) begin
                status <= 4'b0001;
                counter <= 4'b0000;
            end else begin
                counter <= counter + 4'b0001;
            end
        end
        4'b0001: begin
            if (counter == 4'b1111) begin
                if (|row) begin
                    rp <= row;
                    cp <= 2'b01;
                    counter <= 4'b0000;
                    status <= 4'b0000;
                    enable <= 1;
                end else begin
                    status <= 4'b0010;
                    counter <= 4'b0000;
                end
            end else begin
                counter <= counter + 4'b0001;
            end
        end
        4'b0010: begin
            if (counter == 4'b1111) begin
                if (|row) begin
                    rp <= row;
                    cp <= 2'b10;
                    counter <= 4'b0000;
                    status <= 4'b0000;
                    enable <= 1;
                end else begin
                    status <= 4'b0100;
                    counter <= 4'b0000;
                end
            end else begin
                counter <= counter + 4'b0001;
            end           
        end
        4'b0100: begin
            if (counter == 4'b1111) begin
                if (|row) begin
                    rp <= row;
                    cp <= 2'b11;
                    counter <= 4'b0000;
                    status <= 4'b0000;
                    enable <= 1;
                end else begin
                    status <= 4'b1000;
                    counter <= 4'b0000;
                end
            end else begin
                counter <= counter + 4'b0001;
            end
        end
        4'b1000: begin
            if (counter == 4'b1111) begin
                if (|row) begin
                    rp <= row;
                    cp <= 2'b00;
                    counter <= 4'b0000;
                    status <= 4'b0000;
                    enable <= 1;
                end else begin
                    status <= 4'b0000;
                    counter <= 4'b0000;
                    rp <= 4'b0000;
                    cp <= 2'b00;
                    enable <= 0;
                end
            end else begin
                counter <= counter + 4'b0001;
            end
        end
    endcase
end

endmodule
