module Snake (CLK_100MHz, reset, dir randX, randY, 
			  CurrentX, CurrentY, RED, GREEN, BLUE, HS, VS);
	input CLK_100MHz, reset;  
	input [3:0] 
			  [3:0] RED, [3:0] GREEN, [3:0] BLUE
              
    logic[3:0] dir;
    logic [9:0] randX;
    logic [9:0] randY;
    logic displayArea, apple;
    logic border;
    logic eat;
    logic R,G,B;
    logic snake;
    logic stop;
    logic gameOver;
    logic head;
    logic [9:0] appleX;
    logic [9:0] appleY;
    logic inX, inY;
    logic [9:0] snakeX[0:10];
    logic [9:0] snakeY[0:10];
    logic [9:0] headX;
    logic [9:0] headY;
    logic snakeHead;
    logic snakeBody;
                       
    always @(posedge CLK_100MHz) 
	 begin
        inX <= (CurrentX > appleX & CurrentX < (appleX + 10));
        inY <= (CurrentY > appleY & CurrentY < (appleY + 10));
        apple <= inX & inY;
    end
                                  
    always@(posedge CLK_100MHz)
	begin
		border <= (((CurrentX >= 0) & (CurrentX < 20)) | ((CurrentX >= 780) & (CurrentX < 800)) 
				  | ((CurrentY >= 0) & (CurrentY < 20)) | ((CurrentY >= 580) & (CurrentY < 600)));
	end
			  
    always@(posedge CLK_100MHz)
	begin    
        if(reset) begin
            appleX = 400;
            appleY = 300;
        end 
		
        if(apple & head) begin 
            appleX <= randX;
            appleY <= randY;
        end                        
    end
             
    always@(posedge update_clock) begin         
    snakeX[10] <= snakeX[9];
    snakeY[10] <= snakeY[9];
    snakeX[9] <= snakeX[8];
    snakeY[9] <= snakeY[8];
    snakeX[8] <= snakeX[7];
    snakeY[8] <= snakeY[7];
    snakeX[7] <= snakeX[6];
    snakeY[7] <= snakeY[6];
    snakeX[6] <= snakeX[5];
    snakeY[6] <= snakeY[5];
    snakeX[5] <= snakeX[4];
    snakeY[5] <= snakeY[4];
    snakeX[4] <= snakeX[3];
    snakeY[4] <= snakeY[3];
    snakeX[3] <= snakeX[2];
    snakeY[3] <= snakeY[2];
    snakeX[2] <= snakeX[1];
    snakeY[2] <= snakeY[1];
    snakeX[1] <= snakeX[0];
    snakeY[1] <= snakeY[0];
                            		//10 changed to 5 for each case
              if(direction == 4'b0001) begin snakeX[0] = snakeX[0] - 5; end //left
                 else if (direction == 4'b0010) begin snakeX[0] = snakeX[0] + 5; end //right
                 else if (direction == 4'b0100) begin snakeY[0] = snakeY[0] - 5; end //up
                 else if(direction == 4'b1000) begin snakeY[0] = snakeY[0] + 5; end //down
                 
              end

           always@(posedge CLK_100MHz) begin
                snake <= ((CurrentX > snakeX[0] & CurrentX < snakeX[10]+10) & (CurrentY > snakeY[0] & CurrentY < snakeY[10]+10));
           end   
           always@(posedge CLK_100MHz) begin
                 head  <= (CurrentX > snakeX[0] & CurrentX < (snakeX[0]+10)) & (CurrentY > snakeY[0] & CurrentY < (snakeY[0]+10));
           end
                        
           always @(posedge CLK_100MHz) begin
               if((border & (snake|head)) | reset) 
				gameOver<=1;
               else 
				gameOver=0;
           end
                    
           assign R = ((apple & ~snake) | gameOver);
           assign G = ((snake & ~gameOver));
           assign B = (border & ~gameOver));
           
           always@(posedge CLK_100MHz) begin
                   RED = {4{R}};
                   GREEN = {4{G}};
                   BLUE = {4{B}};
           end             
endmodule 

