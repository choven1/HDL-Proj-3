module Snake (CLK_100MHz,CLK_update,Reset,go,dir,randX,randY,VBlank,HBlank,
			  CurrentX,CurrentY,RED,GREEN,BLUE);
	input CLK_100MHz, CLK_update, Reset, VBlank, HBlank, go;
	input [10:0] randX, randY, CurrentX, CurrentY;  
	input [1:0] dir; 
	output reg [3:0] RED, GREEN, BLUE;
    
    reg displayArea, apple, border, snake, gameOver, head, temp;
    wire R, G, B;
    reg [10:0] appleX, appleY;
    reg [10:0] snakeX[0:31]; // snake body X positions
    reg [10:0] snakeY[0:31]; // snake body Y positions
    reg [10:0] snakeX2[0:31]; // snake body X positions
    reg [10:0] snakeY2[0:31]; // snake body Y positions
    reg pause;
    reg [4:0] size;
	integer i, j ,k;
			  
    always@(posedge CLK_100MHz) begin
        if (go) begin pause <= 0; size <= 4; end 
        if(Reset || gameOver) begin
            appleX <= 400;
            appleY <= 300;
            snakeX2[0] <= 100;
            snakeY2[0] <= 500;
            pause <= 1;
            size <= 1;
            for(i=1; i<32; i=i+1) begin
                snakeX2[i] <= 0;
                snakeY2[i] <= 0;
            end
        end
        else if (~pause) begin
            case(dir) //20 pixel shift
                2'b00: snakeY2[0] <= snakeY[0] - 20; //up
                2'b01: snakeX2[0] <= snakeX[0] + 20; //right
                2'b10: snakeY2[0] <= snakeY[0] + 20; //down
                2'b11: snakeX2[0] <= snakeX[0] - 20; //left
                default: snakeY2[0] <= snakeY[0] - 20; //up 
            endcase
    
            for(j=1; j<32; j=j+1) begin
                snakeX2[j] <= snakeX[j-1];
                snakeY2[j] <= snakeY[j-1];
            end
        end
        else begin
            for (i=0; i<32; i=i+1) begin
                snakeX2[i] <= snakeX2[i];
                snakeY2[i] <= snakeY2[i];
            end
        end
        if(apple && head) begin
            appleX <= randX;
            appleY <= randY;
            size <= (size<31) ? size+1: size;
        end
    end
         
    always@(posedge CLK_update) begin
        snakeX[0] <= snakeX2[0];
        snakeY[0] <= snakeY2[0];
        for(i=1; i<32; i=i+1) begin
          snakeX[i] <= snakeX2[i];
          snakeY[i] <= snakeY2[i];
        end
	end
                            		
 
    always@(*) begin
		border = (CurrentX <= 20) || (CurrentX >= 780) || (CurrentY <= 20) || (CurrentY >= 580);
		apple  = (CurrentX > appleX && CurrentX < (appleX+20)) && (CurrentY > appleY & CurrentY < (appleY+20));
        head   = (CurrentX > snakeX[0] && CurrentX < (snakeX[0]+20)) && (CurrentY > snakeY[0] && CurrentY < (snakeY[0]+20));
		temp   = 0;
		for (k=1; k<size; k=k+1) 
			temp = temp || ((CurrentX > snakeX[k] && CurrentX < snakeX[k]+20) && (CurrentY > snakeY[k] && CurrentY < snakeY[k]+20));
		snake = temp;
    end
                        
    always @(posedge CLK_100MHz) begin
        if((border && head) || (head && snake))
			gameOver <= 1;
        else 
			gameOver <= 0;
    end
     
    assign R = (apple && ~snake) || (gameOver && ~Reset);
    assign G = (head || snake) && ~gameOver;
    assign B = (border && ~gameOver);
           
    always@(posedge CLK_100MHz) 
    begin
        if(VBlank || HBlank) 
			{RED,GREEN,BLUE} <= 0; 
         else
			{RED,GREEN,BLUE}  <= {{4{R}},{4{G}},{4{B}}}; 
    end             
endmodule 
