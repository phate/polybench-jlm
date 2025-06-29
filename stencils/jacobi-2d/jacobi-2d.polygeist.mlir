#map = affine_map<(d0) -> (1, d0 * 32)>
#map1 = affine_map<(d0) -> (1299, d0 * 32 + 32)>
#map2 = affine_map<(d0) -> (2, d0 * 32)>
#map3 = affine_map<(d0) -> (1300, d0 * 32 + 32)>
#set = affine_set<(d0) : (d0 == 0)>
#set1 = affine_set<(d0) : (d0 - 40 == 0)>
module attributes {} {
  llvm.mlir.global internal constant @str7("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @str0("\00") {addr_space = 0 : i32}
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 1.300000e+03 : f64
    %cst_0 = arith.constant 2.000000e-01 : f64
    %c2_i32 = arith.constant 2 : i32
    %cst_1 = arith.constant 2.000000e+00 : f64
    %c3_i32 = arith.constant 3 : i32
    %cst_2 = arith.constant 3.000000e+00 : f64
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c1300_i32 = arith.constant 1300 : i32
    %alloc = memref.alloc() : memref<1300x1300xf64>
    %alloc_3 = memref.alloc() : memref<1300x1300xf64>
    %cast = memref.cast %alloc : memref<1300x1300xf64> to memref<?x1300xf64>
    affine.for %arg2 = 0 to 1300 {
      affine.for %arg3 = 0 to 1300 {
        %1 = arith.index_cast %arg2 : index to i32
        %2 = arith.sitofp %1 : i32 to f64
        %3 = arith.index_cast %arg3 : index to i32
        %4 = arith.addi %3, %c2_i32 : i32
        %5 = arith.sitofp %4 : i32 to f64
        %6 = arith.mulf %2, %5 : f64
        %7 = arith.addf %6, %cst_1 : f64
        %8 = arith.divf %7, %cst : f64
        affine.store %8, %alloc[%arg2, %arg3] : memref<1300x1300xf64>
        %9 = arith.index_cast %arg2 : index to i32
        %10 = arith.sitofp %9 : i32 to f64
        %11 = arith.index_cast %arg3 : index to i32
        %12 = arith.addi %11, %c3_i32 : i32
        %13 = arith.sitofp %12 : i32 to f64
        %14 = arith.mulf %10, %13 : f64
        %15 = arith.addf %14, %cst_2 : f64
        %16 = arith.divf %15, %cst : f64
        affine.store %16, %alloc_3[%arg2, %arg3] : memref<1300x1300xf64>
      }
    }
    affine.for %arg2 = 0 to 500 {
      affine.for %arg3 = 0 to 41 {
        affine.for %arg4 = 0 to 41 {
          affine.if #set(%arg3) {
            affine.for %arg5 = max #map(%arg4) to min #map1(%arg4) {
              %1 = affine.load %alloc[1, %arg5] : memref<1300x1300xf64>
              %2 = affine.load %alloc[1, %arg5 - 1] : memref<1300x1300xf64>
              %3 = arith.addf %1, %2 : f64
              %4 = affine.load %alloc[1, %arg5 + 1] : memref<1300x1300xf64>
              %5 = arith.addf %3, %4 : f64
              %6 = affine.load %alloc[2, %arg5] : memref<1300x1300xf64>
              %7 = arith.addf %5, %6 : f64
              %8 = affine.load %alloc[0, %arg5] : memref<1300x1300xf64>
              %9 = arith.addf %7, %8 : f64
              %10 = arith.mulf %9, %cst_0 : f64
              affine.store %10, %alloc_3[1, %arg5] : memref<1300x1300xf64>
            }
          }
          affine.for %arg5 = max #map2(%arg3) to min #map1(%arg3) {
            affine.if #set(%arg4) {
              %1 = affine.load %alloc[%arg5, 1] : memref<1300x1300xf64>
              %2 = affine.load %alloc[%arg5, 0] : memref<1300x1300xf64>
              %3 = arith.addf %1, %2 : f64
              %4 = affine.load %alloc[%arg5, 2] : memref<1300x1300xf64>
              %5 = arith.addf %3, %4 : f64
              %6 = affine.load %alloc[%arg5 + 1, 1] : memref<1300x1300xf64>
              %7 = arith.addf %5, %6 : f64
              %8 = affine.load %alloc[%arg5 - 1, 1] : memref<1300x1300xf64>
              %9 = arith.addf %7, %8 : f64
              %10 = arith.mulf %9, %cst_0 : f64
              affine.store %10, %alloc_3[%arg5, 1] : memref<1300x1300xf64>
            }
            affine.for %arg6 = max #map2(%arg4) to min #map1(%arg4) {
              %1 = affine.load %alloc_3[%arg5 - 1, %arg6 - 1] : memref<1300x1300xf64>
              %2 = affine.load %alloc_3[%arg5 - 1, %arg6 - 2] : memref<1300x1300xf64>
              %3 = arith.addf %1, %2 : f64
              %4 = affine.load %alloc_3[%arg5 - 1, %arg6] : memref<1300x1300xf64>
              %5 = arith.addf %3, %4 : f64
              %6 = affine.load %alloc_3[%arg5, %arg6 - 1] : memref<1300x1300xf64>
              %7 = arith.addf %5, %6 : f64
              %8 = affine.load %alloc_3[%arg5 - 2, %arg6 - 1] : memref<1300x1300xf64>
              %9 = arith.addf %7, %8 : f64
              %10 = arith.mulf %9, %cst_0 : f64
              affine.store %10, %alloc[%arg5 - 1, %arg6 - 1] : memref<1300x1300xf64>
              %11 = affine.load %alloc[%arg5, %arg6] : memref<1300x1300xf64>
              %12 = affine.load %alloc[%arg5, %arg6 - 1] : memref<1300x1300xf64>
              %13 = arith.addf %11, %12 : f64
              %14 = affine.load %alloc[%arg5, %arg6 + 1] : memref<1300x1300xf64>
              %15 = arith.addf %13, %14 : f64
              %16 = affine.load %alloc[%arg5 + 1, %arg6] : memref<1300x1300xf64>
              %17 = arith.addf %15, %16 : f64
              %18 = affine.load %alloc[%arg5 - 1, %arg6] : memref<1300x1300xf64>
              %19 = arith.addf %17, %18 : f64
              %20 = arith.mulf %19, %cst_0 : f64
              affine.store %20, %alloc_3[%arg5, %arg6] : memref<1300x1300xf64>
            }
            affine.if #set1(%arg4) {
              %1 = affine.load %alloc_3[%arg5 - 1, 1298] : memref<1300x1300xf64>
              %2 = affine.load %alloc_3[%arg5 - 1, 1297] : memref<1300x1300xf64>
              %3 = arith.addf %1, %2 : f64
              %4 = affine.load %alloc_3[%arg5 - 1, 1299] : memref<1300x1300xf64>
              %5 = arith.addf %3, %4 : f64
              %6 = affine.load %alloc_3[%arg5, 1298] : memref<1300x1300xf64>
              %7 = arith.addf %5, %6 : f64
              %8 = affine.load %alloc_3[%arg5 - 2, 1298] : memref<1300x1300xf64>
              %9 = arith.addf %7, %8 : f64
              %10 = arith.mulf %9, %cst_0 : f64
              affine.store %10, %alloc[%arg5 - 1, 1298] : memref<1300x1300xf64>
            }
          }
          affine.if #set1(%arg3) {
            affine.for %arg5 = max #map2(%arg4) to min #map3(%arg4) {
              %1 = affine.load %alloc_3[1298, %arg5 - 1] : memref<1300x1300xf64>
              %2 = affine.load %alloc_3[1298, %arg5 - 2] : memref<1300x1300xf64>
              %3 = arith.addf %1, %2 : f64
              %4 = affine.load %alloc_3[1298, %arg5] : memref<1300x1300xf64>
              %5 = arith.addf %3, %4 : f64
              %6 = affine.load %alloc_3[1299, %arg5 - 1] : memref<1300x1300xf64>
              %7 = arith.addf %5, %6 : f64
              %8 = affine.load %alloc_3[1297, %arg5 - 1] : memref<1300x1300xf64>
              %9 = arith.addf %7, %8 : f64
              %10 = arith.mulf %9, %cst_0 : f64
              affine.store %10, %alloc[1298, %arg5 - 1] : memref<1300x1300xf64>
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
        func.call @print_array(%c1300_i32, %cast) : (i32, memref<?x1300xf64>) -> ()
      }
    }
    memref.dealloc %alloc : memref<1300x1300xf64>
    memref.dealloc %alloc_3 : memref<1300x1300xf64>
    return %c0_i32 : i32
  }
  func.func private @strcmp(memref<?xi8>, memref<?xi8>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>}
  func.func private @print_array(%arg0: i32, %arg1: memref<?x1300xf64>) attributes {llvm.linkage = #llvm.linkage<internal>} {
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
    %12 = llvm.getelementptr %11[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    %13 = llvm.call @fprintf(%8, %10, %12) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %14 = llvm.mlir.addressof @str5 : !llvm.ptr
    %15 = llvm.getelementptr %14[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<8 x i8>
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
        %37 = affine.load %arg1[%arg2, %arg3] : memref<?x1300xf64>
        %38 = llvm.call @fprintf(%36, %15, %37) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
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
