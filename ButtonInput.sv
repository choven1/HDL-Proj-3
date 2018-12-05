
module ButtonInput (CLK_100MHz,Up,Right,Down,Left,dir);
	input CLK_100MHz, Up, Right, Down, Left;
	output [1:0] dir;
	
    always@(posedge CLK_100MHz) begin
    
        if(Up == 1) 
            dir <= 4'b00; //left
        else if(Right == 1) 
            dir <= 4'b01; //right
        else if(Down == 1) 
            dir <= 4'b10; //up
        else if(Left == 1)  
            dir <=4'b1000; //down
        else 
            dir <= dir; //keep last input
            //hopelly this stops the requirement of a debouncer
            //life's too short for spending time on debouncers
    end
endmodule