// VGAStart.v - Top level module for example VGA driver implementation in Verilog
// UW EE 4490 
// Adapted from original code by Jerry C. Hamann
// Adapted again to use new modules by James Mock

module FirstVGA(VS, HS, RED, GREEN, BLUE, CLK_100MHz, Reset, Go, Up, Right, Down, Left);
    output          VS, HS; 
    output [3:0]    RED, GREEN, BLUE;
    input  		    Up, Right, Down, Left;
    input           CLK_100MHz, Reset, Go;
    
    wire            HBlank, VBlank, CLK_update, gameOver;
    wire   [10:0]   CurrentX, CurrentY;
	wire   [10:0]	randX, randY;
	wire   [1:0]	dir;

    // Connect to driver of VGA signals
    VGALLDriver 	vgadll(.VS(VS),.HS(HS),.VBlank(VBlank),.HBlank(HBlank),
                       .CurrentX(CurrentX),.CurrentY(CurrentY), 
                       .CLK_100MHz(CLK_100MHz),.Reset(Reset));
   
    // Connect to "client" which produces pixel color based on (X,Y) location
    Snake   	game1(.CLK_100MHz(CLK_100MHz),.CLK_update(CLK_update),.Reset(Reset),.Go(Go),.dir(dir),.gameOver(gameOver),.randX(randX),.randY(randY),.VBlank(VBlank),.HBlank(HBlank),
					 .CurrentX(CurrentX),.CurrentY(CurrentY),.RED(RED),.GREEN(GREEN),.BLUE(BLUE));
					  
	RandomPoint	game2(.CLK_100MHz(CLK_100MHz),.randX(randX),.randY(randY));
	
	ButtonInput game3(.CLK_100MHz(CLK_100MHz),.gameOver(gameOver),.Up(Up),.Right(Right),.Down(Down),.Left(Left),.dir(dir));
	
	UpdateClk   game4(.CLK_100MHz(CLK_100MHz),.CLK_update(CLK_update));
endmodule
