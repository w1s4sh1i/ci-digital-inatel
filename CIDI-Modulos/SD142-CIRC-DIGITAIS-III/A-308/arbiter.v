module arbiter( r , Resetn , Clock , g ) ;
  input [ 1 : 3 ] r ;
  input Resetn , Clock ;
  output wire [ 1 : 3 ] g ;
  reg [ 2 : 1 ] y , Y;
  parameter Idle = 2'b00 , gnt1 = 2'b01 , gnt2 = 2'b10 , gnt3 = 2'b11 ;
  // Next s t a t e com bi na tio nal c i r c u i t
  always @( r , y )
  case ( y )
    Idle :
    casex ( r )
      3'b000 :
        Y = Idle ;
      3'b1xx :
        Y = gnt1 ;
      3'b01x :
        Y = gnt2 ;
      3'b001 :
        Y = gnt3 ;
      default :
        Y = Idle ;
    endcase
    gnt1 :
      if ( r [ 1 ] )
        Y = gnt1 ;
      else
        Y = Idle ;
    gnt2 :
      if ( r [ 2 ] )
        Y = gnt2 ;
      else
        Y = Idle ;
    gnt3 :
      if ( r [ 3 ] )
        Y = gnt3 ;
      else
        Y = Idle ;
    default :
      Y = Idle ;
  endcase

  // S e q u e n ti al blo c k
  always @( posedge Clock )
    if ( Resetn == 0 )
      y <= Idle ;
    else
      y <= Y;

  // D e fi n e output
  assign g[1] = ( y == gnt1 ) ;
  assign g[2] = ( y == gnt2 ) ;
  assign g[3] = ( y == gnt3 ) ;
endmodule



module arbiter_tb;

  // Parameters

  //Ports
  reg [ 1 : 3 ] r;
  reg Resetn ;
  reg  Clock;
  wire [ 1 : 3 ] g;

  arbiter  arbiter_inst (
    .r(r),
    .Resetn (Resetn ),
    . Clock( Clock),
    .g(g)
  );
  
  always #5  Clock = ! Clock ;

  
  reg [15*8-1 : 0] string_vector [0 : 3];
  initial
  begin
    string_vector[0] = "Idle";
    string_vector[1] = "gnt1";
    string_vector[2] = "gnt2";
    string_vector[3] = "gnt3";
  end
  
  integer i,seed;
  
  always @(posedge Clock)
  begin
      $display("At time: %t Current State: %s, r: %b, g: %b",$time,string_vector[arbiter_inst.Y],r,g);
      seed = $time;
      r = $random(seed); 
  end

  
  initial begin
      Resetn = 1; 
      Clock = 0; 
    
      #5;
    
      Resetn = 0; 
      #500;
      $stop;
  end

endmodule