#map = affine_map<(d0) -> (5, d0 * 32)>
#map1 = affine_map<(d0) -> (2000, d0 * 32 + 32)>
#map2 = affine_map<(d0) -> (d0 * 32)>
#set = affine_set<(d0) : (d0 == 0)>
module attributes {} {
  llvm.mlir.global internal constant @str6("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("w\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str0("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c3_i32 = arith.constant 3 : i32
    %cst = arith.constant 3.3333333333333332E-4 : f64
    %cst_0 = arith.constant 5.000000e-04 : f64
    %c4_i32 = arith.constant 4 : i32
    %cst_1 = arith.constant 4.1666666666666669E-4 : f64
    %cst_2 = arith.constant 6.250000e-04 : f64
    %cst_3 = arith.constant 2.000000e+03 : f64
    %cst_4 = arith.constant 1.500000e+00 : f64
    %cst_5 = arith.constant 1.200000e+00 : f64
    %c1_i32 = arith.constant 1 : i32
    %cst_6 = arith.constant 2.000000e+00 : f64
    %cst_7 = arith.constant 4.000000e+00 : f64
    %cst_8 = arith.constant 6.000000e+00 : f64
    %cst_9 = arith.constant 8.000000e+00 : f64
    %cst_10 = arith.constant 9.000000e+00 : f64
    %cst_11 = arith.constant 0.000000e+00 : f64
    %c0_i32 = arith.constant 0 : i32
    %c2000_i32 = arith.constant 2000 : i32
    %alloc = memref.alloc() : memref<2000x2000xf64>
    %alloc_12 = memref.alloc() : memref<2000xf64>
    %alloc_13 = memref.alloc() : memref<2000xf64>
    %cast = memref.cast %alloc_12 : memref<2000xf64> to memref<?xf64>
    %alloca = memref.alloca() : memref<f64>
    %alloca_14 = memref.alloca() : memref<f64>
    affine.for %arg2 = 0 to 2000 {
      affine.for %arg3 = 0 to 63 {
        affine.if #set(%arg3) {
          affine.for %arg4 = 0 to 3 {
            %31 = arith.index_cast %arg2 : index to i32
            %32 = arith.index_cast %arg4 : index to i32
            %33 = arith.muli %31, %32 : i32
            %34 = arith.remsi %33, %c2000_i32 : i32
            %35 = arith.sitofp %34 : i32 to f64
            %36 = arith.divf %35, %cst_3 : f64
            affine.store %36, %alloc[%arg2, %arg4] : memref<2000x2000xf64>
            %37 = affine.load %alloc[%arg2, %arg4] : memref<2000x2000xf64>
            %38 = affine.load %alloca[] : memref<f64>
            %39 = affine.load %alloca_14[] : memref<f64>
            %40 = arith.index_cast %arg4 : index to i32
            %41 = arith.addi %40, %c1_i32 : i32
            %42 = arith.sitofp %41 : i32 to f64
            %43 = arith.divf %42, %cst_3 : f64
            %44 = arith.divf %43, %cst_7 : f64
            %45 = arith.mulf %38, %44 : f64
            %46 = arith.addf %37, %45 : f64
            %47 = arith.divf %43, %cst_8 : f64
            %48 = arith.mulf %39, %47 : f64
            %49 = arith.addf %46, %48 : f64
            affine.store %49, %alloc[%arg2, %arg4] : memref<2000x2000xf64>
          }
          %0 = arith.index_cast %arg2 : index to i32
          %1 = arith.addi %0, %c1_i32 : i32
          %2 = arith.sitofp %1 : i32 to f64
          %3 = arith.divf %2, %cst_3 : f64
          %4 = arith.divf %3, %cst_6 : f64
          memref.store %4, %alloca_14[] : memref<f64>
          %5 = arith.index_cast %arg2 : index to i32
          %6 = arith.muli %5, %c3_i32 : i32
          %7 = arith.remsi %6, %c2000_i32 : i32
          %8 = arith.sitofp %7 : i32 to f64
          %9 = arith.divf %8, %cst_3 : f64
          affine.store %9, %alloc[%arg2, 3] : memref<2000x2000xf64>
          %10 = affine.load %alloc[%arg2, 3] : memref<2000x2000xf64>
          %11 = affine.load %alloca[] : memref<f64>
          %12 = affine.load %alloca_14[] : memref<f64>
          %13 = arith.mulf %11, %cst_0 : f64
          %14 = arith.addf %10, %13 : f64
          %15 = arith.mulf %12, %cst : f64
          %16 = arith.addf %14, %15 : f64
          affine.store %16, %alloc[%arg2, 3] : memref<2000x2000xf64>
          %17 = arith.index_cast %arg2 : index to i32
          %18 = arith.sitofp %17 : i32 to f64
          memref.store %18, %alloca[] : memref<f64>
          %19 = arith.index_cast %arg2 : index to i32
          %20 = arith.muli %19, %c4_i32 : i32
          %21 = arith.remsi %20, %c2000_i32 : i32
          %22 = arith.sitofp %21 : i32 to f64
          %23 = arith.divf %22, %cst_3 : f64
          affine.store %23, %alloc[%arg2, 4] : memref<2000x2000xf64>
          %24 = affine.load %alloc[%arg2, 4] : memref<2000x2000xf64>
          %25 = affine.load %alloca[] : memref<f64>
          %26 = affine.load %alloca_14[] : memref<f64>
          %27 = arith.mulf %25, %cst_2 : f64
          %28 = arith.addf %24, %27 : f64
          %29 = arith.mulf %26, %cst_1 : f64
          %30 = arith.addf %28, %29 : f64
          affine.store %30, %alloc[%arg2, 4] : memref<2000x2000xf64>
        }
        affine.for %arg4 = max #map(%arg3) to min #map1(%arg3) {
          %0 = arith.index_cast %arg2 : index to i32
          %1 = arith.index_cast %arg4 : index to i32
          %2 = arith.muli %0, %1 : i32
          %3 = arith.remsi %2, %c2000_i32 : i32
          %4 = arith.sitofp %3 : i32 to f64
          %5 = arith.divf %4, %cst_3 : f64
          affine.store %5, %alloc[%arg2, %arg4] : memref<2000x2000xf64>
          %6 = affine.load %alloc[%arg2, %arg4] : memref<2000x2000xf64>
          %7 = affine.load %alloca[] : memref<f64>
          %8 = affine.load %alloca_14[] : memref<f64>
          %9 = arith.index_cast %arg4 : index to i32
          %10 = arith.addi %9, %c1_i32 : i32
          %11 = arith.sitofp %10 : i32 to f64
          %12 = arith.divf %11, %cst_3 : f64
          %13 = arith.divf %12, %cst_7 : f64
          %14 = arith.mulf %7, %13 : f64
          %15 = arith.addf %6, %14 : f64
          %16 = arith.divf %12, %cst_8 : f64
          %17 = arith.mulf %8, %16 : f64
          %18 = arith.addf %15, %17 : f64
          affine.store %18, %alloc[%arg2, %arg4] : memref<2000x2000xf64>
        }
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = #map2(%arg2) to min #map1(%arg2) {
        affine.store %cst_11, %alloc_12[%arg3] : memref<2000xf64>
        affine.store %cst_11, %alloc_13[%arg3] : memref<2000xf64>
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = 0 to 63 {
        affine.for %arg4 = #map2(%arg3) to min #map1(%arg3) {
          affine.for %arg5 = #map2(%arg2) to min #map1(%arg2) {
            %0 = affine.load %alloc_13[%arg5] : memref<2000xf64>
            %1 = affine.load %alloc[%arg4, %arg5] : memref<2000x2000xf64>
            %2 = arith.mulf %1, %cst_5 : f64
            %3 = arith.index_cast %arg4 : index to i32
            %4 = arith.addi %3, %c1_i32 : i32
            %5 = arith.sitofp %4 : i32 to f64
            %6 = arith.divf %5, %cst_3 : f64
            %7 = arith.divf %6, %cst_9 : f64
            %8 = arith.mulf %2, %7 : f64
            %9 = arith.addf %0, %8 : f64
            affine.store %9, %alloc_13[%arg5] : memref<2000xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = #map2(%arg2) to min #map1(%arg2) {
        %0 = affine.load %alloc_13[%arg3] : memref<2000xf64>
        %1 = arith.index_cast %arg3 : index to i32
        %2 = arith.addi %1, %c1_i32 : i32
        %3 = arith.sitofp %2 : i32 to f64
        %4 = arith.divf %3, %cst_3 : f64
        %5 = arith.divf %4, %cst_10 : f64
        %6 = arith.addf %0, %5 : f64
        affine.store %6, %alloc_13[%arg3] : memref<2000xf64>
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = 0 to 63 {
        affine.for %arg4 = #map2(%arg2) to min #map1(%arg2) {
          affine.for %arg5 = #map2(%arg3) to min #map1(%arg3) {
            %0 = affine.load %alloc_12[%arg4] : memref<2000xf64>
            %1 = affine.load %alloc[%arg4, %arg5] : memref<2000x2000xf64>
            %2 = arith.mulf %1, %cst_4 : f64
            %3 = affine.load %alloc_13[%arg5] : memref<2000xf64>
            %4 = arith.mulf %2, %3 : f64
            %5 = arith.addf %0, %4 : f64
            affine.store %5, %alloc_12[%arg4] : memref<2000xf64>
          }
        }
      }
    }
    call @print_array(%c2000_i32, %cast) : (i32, memref<?xf64>) -> ()
    memref.dealloc %alloc : memref<2000x2000xf64>
    memref.dealloc %alloc_12 : memref<2000xf64>
    memref.dealloc %alloc_13 : memref<2000xf64>
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
