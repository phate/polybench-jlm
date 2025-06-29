#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (1300, d0 * 32 + 32)>
module attributes {} {
  llvm.mlir.global internal constant @str6("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("y\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str0("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 1.300000e+03 : f64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %cst_1 = arith.constant 1.500000e+00 : f64
    %cst_2 = arith.constant 1.200000e+00 : f64
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %c0_i32 = arith.constant 0 : i32
    %c1300_i32 = arith.constant 1300 : i32
    %alloc = memref.alloc() : memref<1300xf64>
    %alloc_3 = memref.alloc() : memref<1300xf64>
    %cast = memref.cast %alloc_3 : memref<1300xf64> to memref<?xf64>
    affine.for %arg2 = 0 to 41 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        affine.store %cst_0, %alloc_3[%arg3] : memref<1300xf64>
      }
    }
    affine.for %arg2 = 0 to 41 {
      affine.for %arg3 = 0 to 41 {
        affine.for %arg4 = #map(%arg3) to min #map1(%arg3) {
          affine.for %arg5 = #map(%arg2) to min #map1(%arg2) {
            %0 = arith.index_cast %arg5 : index to i32
            %1 = arith.index_cast %arg4 : index to i32
            %2 = arith.muli %0, %1 : i32
            %3 = arith.addi %2, %c2_i32 : i32
            %4 = arith.remsi %3, %c1300_i32 : i32
            %5 = arith.sitofp %4 : i32 to f64
            %6 = arith.divf %5, %cst : f64
            %7 = arith.remsi %1, %c1300_i32 : i32
            %8 = arith.sitofp %7 : i32 to f64
            %9 = arith.divf %8, %cst : f64
            %10 = arith.mulf %6, %9 : f64
            %11 = affine.load %alloc_3[%arg5] : memref<1300xf64>
            %12 = arith.addf %10, %11 : f64
            affine.store %12, %alloc_3[%arg5] : memref<1300xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 41 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        affine.store %cst_0, %alloc[%arg3] : memref<1300xf64>
      }
    }
    affine.for %arg2 = 0 to 41 {
      affine.for %arg3 = 0 to 41 {
        affine.for %arg4 = #map(%arg3) to min #map1(%arg3) {
          affine.for %arg5 = #map(%arg2) to min #map1(%arg2) {
            %0 = arith.index_cast %arg5 : index to i32
            %1 = arith.index_cast %arg4 : index to i32
            %2 = arith.muli %0, %1 : i32
            %3 = arith.addi %2, %c1_i32 : i32
            %4 = arith.remsi %3, %c1300_i32 : i32
            %5 = arith.sitofp %4 : i32 to f64
            %6 = arith.divf %5, %cst : f64
            %7 = arith.remsi %1, %c1300_i32 : i32
            %8 = arith.sitofp %7 : i32 to f64
            %9 = arith.divf %8, %cst : f64
            %10 = arith.mulf %6, %9 : f64
            %11 = affine.load %alloc[%arg5] : memref<1300xf64>
            %12 = arith.addf %10, %11 : f64
            affine.store %12, %alloc[%arg5] : memref<1300xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 41 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        %0 = affine.load %alloc[%arg3] : memref<1300xf64>
        %1 = arith.mulf %0, %cst_1 : f64
        %2 = affine.load %alloc_3[%arg3] : memref<1300xf64>
        %3 = arith.mulf %2, %cst_2 : f64
        %4 = arith.addf %1, %3 : f64
        affine.store %4, %alloc_3[%arg3] : memref<1300xf64>
      }
    }
    call @print_array(%c1300_i32, %cast) : (i32, memref<?xf64>) -> ()
    memref.dealloc %alloc : memref<1300xf64>
    memref.dealloc %alloc_3 : memref<1300xf64>
    return %c0_i32 : i32
  }
  func.func private @print_array(%arg0: i32, %arg1: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<internal>} {
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.addressof @stderr : !llvm.ptr
    %1 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %2 = "polygeist.memref2pointer"(%1) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %3 = llvm.mlir.addressof @str0 : !llvm.ptr
    %4 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %5 = llvm.call @fprintf(%2, %4) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %6 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %7 = "polygeist.memref2pointer"(%6) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %8 = llvm.mlir.addressof @str1 : !llvm.ptr
    %9 = llvm.getelementptr %8[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<15 x i8>
    %10 = llvm.mlir.addressof @str2 : !llvm.ptr
    %11 = llvm.getelementptr %10[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %12 = llvm.call @fprintf(%7, %9, %11) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %13 = arith.index_cast %arg0 : i32 to index
    %14 = llvm.mlir.addressof @str4 : !llvm.ptr
    %15 = llvm.getelementptr %14[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<8 x i8>
    %16 = llvm.mlir.addressof @str3 : !llvm.ptr
    %17 = llvm.getelementptr %16[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    affine.for %arg2 = 0 to %13 {
      %28 = arith.remsi %arg2, %c20 : index
      %29 = arith.cmpi slt, %28, %c0 : index
      %30 = arith.addi %28, %c20 : index
      %31 = arith.select %29, %30, %28 : index
      %32 = arith.cmpi eq, %31, %c0 : index
      scf.if %32 {
        %37 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %38 = "polygeist.memref2pointer"(%37) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %39 = llvm.call @fprintf(%38, %17) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
      }
      %33 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
      %34 = "polygeist.memref2pointer"(%33) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
      %35 = affine.load %arg1[%arg2] : memref<?xf64>
      %36 = llvm.call @fprintf(%34, %15, %35) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    }
    %18 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %19 = "polygeist.memref2pointer"(%18) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %20 = llvm.mlir.addressof @str5 : !llvm.ptr
    %21 = llvm.getelementptr %20[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<17 x i8>
    %22 = llvm.call @fprintf(%19, %21, %11) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %23 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %24 = "polygeist.memref2pointer"(%23) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %25 = llvm.mlir.addressof @str6 : !llvm.ptr
    %26 = llvm.getelementptr %25[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %27 = llvm.call @fprintf(%24, %26) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    return
  }
}
