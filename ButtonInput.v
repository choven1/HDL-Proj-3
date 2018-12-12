//Written by James Mock for the purpose of HDL digital design project 3
//handles the input from buttons up, right, down, and left to tell system which
//direction to travel in.
//prevents movement in direct opposite direction
module ButtonInput (CLK_100MHz,gameOver,Up,Right,Down,Left,dir);
	input CLK_100MHz, gameOver, Up, Right, Down, Left;
	output reg [1:0] dir;
	
    always@(posedge CLK_100MHz) 
	begin
        if(gameOver || (Up && (dir!=2'b10))) 
            dir <= 2'b00; //up
        else if(Right&&(dir!=2'b11)) 
            dir <= 2'b01; //right
        else if(Down&&(dir!=2'b00)) 
            dir <= 2'b10; //down
        else if(Left&&(dir!=2'b01))  
            dir <= 2'b11; //left
        else 
            dir <= dir; //keep last input
            //hopelly this stops the requirement of a debouncer
            //life's too short for spending time on debouncers
    end
endmodule