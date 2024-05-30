module keypad (
    input clk,
    output [3:0] col,
    input [3:0] row,
    output [3:0] rowPressed,
    output [3:0] colPressed
);

reg [3:0] rp;
reg [3:0] cp;

assign rowPressed = rp;
assign colPressed = cp;

reg [3:0] status = 4'b0000;
assign col = status;
reg [3:0] counter = 4'b0000;

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
                    cp <= status;
                    counter <= 4'b0000;
                    status <= 4'b0000;
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
                    cp <= status;
                    counter <= 4'b0000;
                    status <= 4'b0000;
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
                    cp <= status;
                    counter <= 4'b0000;
                    status <= 4'b0000;
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
                    cp <= status;
                    counter <= 4'b0000;
                    status <= 4'b0000;
                end else begin
                    status <= 4'b0000;
                    counter <= 4'b0000;
                    rp <= 4'b0000;
                    cp <= 4'b0000;
                end
            end else begin
                counter <= counter + 4'b0001;
            end
        end
    endcase
end

endmodule
