//Written by James Mock and Corey Hoven
//handles the logic for snake game displayed on a screen
//deals with collisions and sprite movement and other interactions.
module Snake (CLK_100MHz,CLK_update,Reset,Go,dir,gameOver,randX,randY,VBlank,HBlank,
			  CurrentX,CurrentY,RED,GREEN,BLUE);
    input CLK_100MHz, CLK_update, Reset, VBlank, HBlank, Go;
    input [10:0] randX, randY, CurrentX, CurrentY;  
    input [1:0] dir; 
    output reg gameOver;
    output reg [3:0] RED, GREEN, BLUE;
    
    parameter MAXSIZE = 127; //can be set to any multiple of 4 plus 3 more (k*4)+3=MAXSIZE
    reg displayArea, apple, border, snake, head, temp;
    wire R, G, B;
    reg [10:0] appleX, appleY;
    reg [10:0] snakeX[0:MAXSIZE]; // snake body X positions
    reg [10:0] snakeY[0:MAXSIZE]; // snake body Y positions
    reg [10:0] snakeX2[0:MAXSIZE]; // next snake body X positions
    reg [10:0] snakeY2[0:MAXSIZE]; // next snake body Y positions
    reg pause;
    reg [6:0] size; //set bit width to match appropriately to MAXSIZE
    integer i, j ,k, m; 
			  
    always@(posedge CLK_100MHz) begin
        if (Go) pause <= 0;
        if(Reset || gameOver) begin //handles reset sequence to initialze the game
            appleX <= 400;
            appleY <= 300;
            snakeX2[0] <= 100;
            snakeY2[0] <= 500;
            pause <= 1;
            size <= 3;
            for(i=1; i<MAXSIZE; i=i+1) begin
                snakeX2[i] <= 0;
                snakeY2[i] <= 0;
            end
        end
		//standard operation that handles snake movement and direction
        else if (~pause) begin 
            case(dir) //20 pixel shift user control
                2'b00: begin snakeY2[0] <= snakeY[0] - 20; //up
                             snakeX2[0] <= snakeX[0]; end
                2'b01: begin snakeX2[0] <= snakeX[0] + 20; //right
                             snakeY2[0] <= snakeY[0]; end
                2'b10: begin snakeY2[0] <= snakeY[0] + 20; //down
                             snakeX2[0] <= snakeX[0]; end
                2'b11: begin snakeX2[0] <= snakeX[0] - 20; //left
                             snakeY2[0] <= snakeY[0]; end
                default: begin snakeY2[0] <= snakeY[0] - 20; //up 
                               snakeX2[0] <= snakeX[0]; end
            endcase
            // update all sections
            for(j=1; j<MAXSIZE; j=j+1) begin
                snakeX2[j] <= snakeX[j-1];
                snakeY2[j] <= snakeY[j-1];
            end
        end
        else begin //manages non-running snake location for clarity
            for (i=0; i<MAXSIZE; i=i+1) begin
                snakeX2[i] <= snakeX2[i];
                snakeY2[i] <= snakeY2[i];
            end
        end
        // apple collisions
        if(apple && head) begin //handles valid collision with head and apple.
            appleX <= randX;
            appleY <= randY;
            size <= (size<MAXSIZE) ? size+4: size; 
	end // expand by four sections
            
        // gameover collisions    
        if((border && head) || (head && snake))
            gameOver <= 1;
        else 
            gameOver <= 0;
    end
         
	//assigns the movement value to the actual location of the snake sprite
    always@(posedge CLK_update) begin 
        for(m=0; m<MAXSIZE; m=m+1) begin
          snakeX[m] <= snakeX2[m];
          snakeY[m] <= snakeY2[m];
        end
	end
                            		
	//determines if current location is within a border wall, the snake, or an apple for use of drawing
	//and collision detection
    always@(*) begin
		border = (CurrentX <= 20) || (CurrentX >= 780) || (CurrentY <= 20) || (CurrentY >= 580);
		apple  = (CurrentX > appleX && CurrentX < (appleX+20)) && (CurrentY > appleY & CurrentY < (appleY+20));
        head   = (CurrentX > snakeX[0] && CurrentX < (snakeX[0]+20)) && (CurrentY > snakeY[0] && CurrentY < (snakeY[0]+20));
		temp   = 0;
		for (k=1; k<=size; k=k+1) 
			temp = temp || ((CurrentX > snakeX[k] && CurrentX < snakeX[k]+20) && (CurrentY > snakeY[k] && CurrentY < snakeY[k]+20));
		snake = temp;
    end
    
	//handles the value of R, G, and B based on location logic
    assign R = apple && ~snake;
    assign G = (head || snake) && ~border;
    assign B = border;
	
	//set the value of the output signals RED,GREEN, and BLUE
    always@(posedge CLK_100MHz) 
    begin
        if(VBlank || HBlank) 
			{RED,GREEN,BLUE} <= 0; 
         else
			{RED,GREEN,BLUE}  <= {{4{R}},{4{G}},{4{B}}}; 
    end             
endmodule 

