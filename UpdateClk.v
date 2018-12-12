//Modified by James Mock from an internet source
//used to generate a slower clock speed used in the movement
//of screen sprites 
module UpdateClk(CLK_100MHz,CLK_update);
	input CLK_100MHz;
	output reg CLK_update;
	reg [21:0]count;	

	always@(posedge CLK_100MHz)
	begin
		if(count == 3000000) begin
			CLK_update <= ~CLK_update;
			count <= 0; end	
		else begin
			CLK_update <= CLK_update;
			count <= count + 1; end
	end
endmodule