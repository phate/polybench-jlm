#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (2800, d0 * 32 + 32)>
module attributes {} {
  llvm.mlir.global internal constant @str7("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("%d \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("path\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @str0("\00") {addr_space = 0 : i32}
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c7_i32 = arith.constant 7 : i32
    %c1_i32 = arith.constant 1 : i32
    %c11_i32 = arith.constant 11 : i32
    %c999_i32 = arith.constant 999 : i32
    %true = arith.constant true
    %c13 = arith.constant 13 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c2800_i32 = arith.constant 2800 : i32
    %alloc = memref.alloc() : memref<2800x2800xi32>
    %cast = memref.cast %alloc : memref<2800x2800xi32> to memref<?x2800xi32>
    affine.for %arg2 = 0 to 2800 {
      %1 = arith.index_cast %arg2 : index to i32
      affine.for %arg3 = 0 to 2800 {
        %2 = arith.index_cast %arg3 : index to i32
        %3 = arith.muli %1, %2 : i32
        %4 = arith.remsi %3, %c7_i32 : i32
        %5 = arith.addi %4, %c1_i32 : i32
        affine.store %5, %alloc[%arg2, %arg3] : memref<2800x2800xi32>
        %6 = arith.addi %1, %2 : i32
        %7 = arith.addi %arg2, %arg3 : index
        %8 = arith.remsi %7, %c13 : index
        %9 = arith.cmpi slt, %8, %c0 : index
        %10 = arith.addi %8, %c13 : index
        %11 = arith.select %9, %10, %8 : index
        %12 = arith.cmpi eq, %11, %c0 : index
        %13 = scf.if %12 -> (i1) {
          scf.yield %true : i1
        } else {
          %15 = arith.remsi %6, %c7_i32 : i32
          %16 = arith.cmpi eq, %15, %c0_i32 : i32
          scf.yield %16 : i1
        }
        %14 = scf.if %13 -> (i1) {
          scf.yield %true : i1
        } else {
          %15 = arith.remsi %6, %c11_i32 : i32
          %16 = arith.cmpi eq, %15, %c0_i32 : i32
          scf.yield %16 : i1
        }
        scf.if %14 {
          affine.store %c999_i32, %alloc[%arg2, %arg3] : memref<2800x2800xi32>
        }
      }
    }
    affine.for %arg2 = 0 to 2800 {
      affine.for %arg3 = 0 to 88 {
        affine.for %arg4 = 0 to 88 {
          affine.for %arg5 = #map(%arg3) to min #map1(%arg3) {
            affine.for %arg6 = #map(%arg4) to min #map1(%arg4) {
              %1 = affine.load %alloc[%arg5, %arg6] : memref<2800x2800xi32>
              %2 = affine.load %alloc[%arg5, %arg2] : memref<2800x2800xi32>
              %3 = affine.load %alloc[%arg2, %arg6] : memref<2800x2800xi32>
              %4 = arith.addi %2, %3 : i32
              %5 = arith.cmpi slt, %1, %4 : i32
              %6 = arith.select %5, %1, %4 : i32
              affine.store %6, %alloc[%arg5, %arg6] : memref<2800x2800xi32>
            }
          }
        }
      }
    }
    %0 = arith.cmpi sgt, %arg0, %c42_i32 : i32
    scf.if %0 {
      %1 = affine.load %arg1[0] : memref<?xmemref<?xi8>>
      %2 = llvm.mlir.addressof @str0 : !llvm.ptr
      %3 = "polygeist.pointer2memref"(%2) : (!llvm.ptr) -> memref<?xi8>
      %4 = func.call @strcmp(%1, %3) : (memref<?xi8>, memref<?xi8>) -> i32
      %5 = arith.cmpi eq, %4, %c0_i32 : i32
      scf.if %5 {
        func.call @print_array(%c2800_i32, %cast) : (i32, memref<?x2800xi32>) -> ()
      }
    }
    memref.dealloc %alloc : memref<2800x2800xi32>
    return %c0_i32 : i32
  }
  func.func private @strcmp(memref<?xi8>, memref<?xi8>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>}
  func.func private @print_array(%arg0: i32, %arg1: memref<?x2800xi32>) attributes {llvm.linkage = #llvm.linkage<internal>} {
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = llvm.mlir.addressof @stderr : !llvm.ptr
    %2 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %3 = "polygeist.memref2pointer"(%2) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %4 = llvm.mlir.addressof @str1 : !llvm.ptr
    %5 = llvm.getelementptr %4[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %6 = llvm.call @fprintf(%3, %5) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %7 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %8 = "polygeist.memref2pointer"(%7) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %9 = llvm.mlir.addressof @str2 : !llvm.ptr
    %10 = llvm.getelementptr %9[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<15 x i8>
    %11 = llvm.mlir.addressof @str3 : !llvm.ptr
    %12 = llvm.getelementptr %11[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<5 x i8>
    %13 = llvm.call @fprintf(%8, %10, %12) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %14 = llvm.mlir.addressof @str5 : !llvm.ptr
    %15 = llvm.getelementptr %14[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4 x i8>
    %16 = llvm.mlir.addressof @str4 : !llvm.ptr
    %17 = llvm.getelementptr %16[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    affine.for %arg2 = 0 to %0 {
      %28 = arith.muli %arg2, %0 : index
      affine.for %arg3 = 0 to %0 {
        %29 = arith.addi %arg3, %28 : index
        %30 = arith.remsi %29, %c20 : index
        %31 = arith.cmpi slt, %30, %c0 : index
        %32 = arith.addi %30, %c20 : index
        %33 = arith.select %31, %32, %30 : index
        %34 = arith.cmpi eq, %33, %c0 : index
        scf.if %34 {
          %39 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
          %40 = "polygeist.memref2pointer"(%39) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
          %41 = llvm.call @fprintf(%40, %17) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
        }
        %35 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %36 = "polygeist.memref2pointer"(%35) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %37 = affine.load %arg1[%arg2, %arg3] : memref<?x2800xi32>
        %38 = llvm.call @fprintf(%36, %15, %37) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
      }
    }
    %18 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %19 = "polygeist.memref2pointer"(%18) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %20 = llvm.mlir.addressof @str6 : !llvm.ptr
    %21 = llvm.getelementptr %20[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<17 x i8>
    %22 = llvm.call @fprintf(%19, %21, %12) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %23 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %24 = "polygeist.memref2pointer"(%23) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %25 = llvm.mlir.addressof @str7 : !llvm.ptr
    %26 = llvm.getelementptr %25[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %27 = llvm.call @fprintf(%24, %26) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    return
  }
}
