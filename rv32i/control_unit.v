module control_unit(
  instruction,
  load,
  reg_write,
  op_b_sel,
  rs2_addr,
  rs1_addr,
  rd_addr,
  op_a_sel,
  imm,
  req,
  alu_op,
  rd_sel,
  mem_read,
  branch_taken,
  jalr,
  jal,
  mem_write
  );

  input wire [31:0] instruction; 
  output reg                req;
  output reg               jalr;
  output reg                jal;
  output reg          reg_write;
  output reg [31:0]         imm;
  output reg           op_b_sel;
  output reg           op_a_sel;
  output reg [4:0]       alu_op;
  output wire[4:0]     rs1_addr;
  output wire[4:0]     rs2_addr;
  output wire[4:0]      rd_addr;
  output reg [1:0]       rd_sel;
  output reg           mem_read;
  output reg          mem_write;
  output reg       branch_taken;
  output reg               load;
  
   assign rs1_addr = instruction[19:15];
   assign rs2_addr = instruction[24:20];
   assign rd_addr  = instruction[11:7];

  always @(*)begin
    branch_taken =0 ;
    jal=0;
    req = 1;
    if(instruction[6:0]== 7'b0110011)begin//r_type 
        reg_write=1;
        op_b_sel=0;
        op_a_sel=0;
        rd_sel=2'b00;

        case(instruction[14:12]) // selection based on func3
          3'b000 : alu_op = (instruction[30]) ? 5'b00001: 5'b00000;// sub//add
          3'b001 : alu_op = 5'b00010;//sll
          3'b010 : alu_op = 5'b01000;//slt
          3'b011 : alu_op = 5'b01001;//sltu
          3'b100 : alu_op = 5'b00111;//xor
          3'b101 : alu_op = (instruction[30]) ? 5'b00100 : 5'b00011;//sra//srl
          3'b110 : alu_op = 5'b00110;//or
          3'b111 : alu_op = 5'b00101;//and
          default : alu_op = 5'b00000; // Handle any unsupported cases
        endcase
    end
    else if(instruction[6:0]==7'b0010011)begin//i_type
      imm = {{20{instruction[31]}}, instruction[31:20]};
      op_b_sel=1;
      op_a_sel=0;
      rd_sel=2'b00;
        case (instruction[14:12])
          3'b000 : alu_op = 5'b01010;//addi
          3'b001 : alu_op = 5'b01011;//slli
          3'b010 : alu_op = 5'b01110;//slti
          3'b011 : alu_op = 5'b01111;//sltui
          3'b100 : alu_op = 5'b10001;//xori
          3'b101 : alu_op = (instruction[30]) ? 5'b01101 : 5'b01100;//srai//srli
          3'b110 : alu_op = 5'b10010;//ori
          3'b111 : alu_op = 5'b10000;//andi
          default : alu_op = 5'b01010; // Handle any unsupported cases
      endcase
      reg_write=1;
    end 
    else if(instruction[6:0]==7'b0000011)begin//load
    load=1;
    imm = {{20{instruction[31]}}, instruction[31:20]};
    mem_read=1;
    reg_write=1;
    op_b_sel=1;
    op_a_sel=0;
    rd_sel=2'b01;
    alu_op = 5'b01010;

    end
    else if (instruction[6:0]==7'b0100011)begin//store
      imm= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]} ;
      mem_write=1;
      reg_write=1;
      op_b_sel=1;
      op_a_sel=0;
      alu_op = 5'b01010;
    end
    else if(instruction[6:0]==7'b1100011)begin//branch
      alu_op = 5'b01010; //addi
      imm = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
      reg_write=1;
      op_b_sel=1;
      op_a_sel=1;
      branch_taken=1;
    end
    else if (instruction[6:0]==7'b0110111)begin//LUI
      imm = { instruction[31:12], 12'b0} ;
      reg_write=1;
      rd_sel=2'b10;
    end
    else if (instruction[6:0]==7'b0010111)begin//AUIPC 
      imm = { instruction[31:12], 12'b0} ;
      reg_write=1;
      op_a_sel=1;
      op_b_sel=1;
      rd_sel=2'b00;
    end
     else if (instruction[6:0]==7'b1101111)begin//JAL
      imm = { {11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21], 1'b0} ;
      reg_write=1;
      jal=1;
      rd_sel=2'b11;
      alu_op = 5'b01010; //addi
      op_a_sel=1;
      op_b_sel=1;
    end
    else if (instruction[6:0]==7'b1100111)begin//JALR
      imm = {{20{instruction[31]}}, instruction[31:20]};
      reg_write=1;
      jalr=1;
      alu_op = 5'b01010; //addi
      op_a_sel=0;
      op_b_sel=1;
    end

  end   
endmodule