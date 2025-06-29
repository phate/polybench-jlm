#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (1000, d0 * 32 + 32)>
#map2 = affine_map<(d0) -> (1200, d0 * 32 + 32)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0, d1) -> (d0 * 32, d1 * 32 + 1)>
#map5 = affine_map<(d0, d1) -> (d0 * 32 + 32, d1)>
#map6 = affine_map<(d0) -> (d0)>
#map7 = affine_map<(d0, d1) -> (999, d0 * 32 + 32, d1 * 32 + 31)>
#map8 = affine_map<(d0, d1) -> (d0 * 32, d1 + 1)>
module attributes {} {
  llvm.mlir.global internal constant @str7("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("B\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @str0("\00") {addr_space = 0 : i32}
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 1.200000e+03 : f64
    %cst_0 = arith.constant 1.000000e+03 : f64
    %cst_1 = arith.constant 1.500000e+00 : f64
    %cst_2 = arith.constant 1.000000e+00 : f64
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c1200_i32 = arith.constant 1200 : i32
    %c1000_i32 = arith.constant 1000 : i32
    %alloc = memref.alloc() : memref<1000x1000xf64>
    %alloc_3 = memref.alloc() : memref<1000x1200xf64>
    %cast = memref.cast %alloc_3 : memref<1000x1200xf64> to memref<?x1200xf64>
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = 0 to 38 {
        affine.for %arg4 = #map(%arg2) to min #map1(%arg2) {
          affine.for %arg5 = #map(%arg3) to min #map2(%arg3) {
            %1 = arith.index_cast %arg4 : index to i32
            %2 = arith.index_cast %arg5 : index to i32
            %3 = arith.subi %1, %2 : i32
            %4 = arith.addi %3, %c1200_i32 : i32
            %5 = arith.remsi %4, %c1200_i32 : i32
            %6 = arith.sitofp %5 : i32 to f64
            %7 = arith.divf %6, %cst : f64
            affine.store %7, %alloc_3[%arg4, %arg5] : memref<1000x1200xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        affine.store %cst_2, %alloc[%arg3, %arg3] : memref<1000x1000xf64>
      }
    }
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = 0 to #map3(%arg2) {
        affine.for %arg4 = max #map4(%arg2, %arg3) to min #map1(%arg2) {
          affine.for %arg5 = #map(%arg3) to min #map5(%arg3, %arg4) {
            %1 = arith.index_cast %arg4 : index to i32
            %2 = arith.index_cast %arg5 : index to i32
            %3 = arith.addi %1, %2 : i32
            %4 = arith.remsi %3, %c1000_i32 : i32
            %5 = arith.sitofp %4 : i32 to f64
            %6 = arith.divf %5, %cst_0 : f64
            affine.store %6, %alloc[%arg4, %arg5] : memref<1000x1000xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 38 {
      affine.for %arg3 = 0 to 32 {
        affine.for %arg4 = #map6(%arg3) to 32 {
          affine.for %arg5 = #map(%arg3) to min #map7(%arg3, %arg4) {
            affine.for %arg6 = max #map8(%arg4, %arg5) to min #map1(%arg4) {
              affine.for %arg7 = #map(%arg2) to min #map2(%arg2) {
                %1 = affine.load %alloc_3[%arg5, %arg7] : memref<1000x1200xf64>
                %2 = affine.load %alloc[%arg6, %arg5] : memref<1000x1000xf64>
                %3 = affine.load %alloc_3[%arg6, %arg7] : memref<1000x1200xf64>
                %4 = arith.mulf %2, %3 : f64
                %5 = arith.addf %1, %4 : f64
                affine.store %5, %alloc_3[%arg5, %arg7] : memref<1000x1200xf64>
              }
            }
          }
        }
      }
    }
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = 0 to 38 {
        affine.for %arg4 = #map(%arg2) to min #map1(%arg2) {
          affine.for %arg5 = #map(%arg3) to min #map2(%arg3) {
            %1 = affine.load %alloc_3[%arg4, %arg5] : memref<1000x1200xf64>
            %2 = arith.mulf %1, %cst_1 : f64
            affine.store %2, %alloc_3[%arg4, %arg5] : memref<1000x1200xf64>
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
        func.call @print_array(%c1000_i32, %c1200_i32, %cast) : (i32, i32, memref<?x1200xf64>) -> ()
      }
    }
    memref.dealloc %alloc : memref<1000x1000xf64>
    memref.dealloc %alloc_3 : memref<1000x1200xf64>
    return %c0_i32 : i32
  }
  func.func private @strcmp(memref<?xi8>, memref<?xi8>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>}
  func.func private @print_array(%arg0: i32, %arg1: i32, %arg2: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<internal>} {
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
    %14 = arith.index_cast %arg1 : i32 to index
    %15 = llvm.mlir.addressof @str5 : !llvm.ptr
    %16 = llvm.getelementptr %15[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<8 x i8>
    %17 = llvm.mlir.addressof @str4 : !llvm.ptr
    %18 = llvm.getelementptr %17[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    affine.for %arg3 = 0 to %0 {
      %29 = arith.muli %arg3, %0 : index
      affine.for %arg4 = 0 to %14 {
        %30 = arith.addi %arg4, %29 : index
        %31 = arith.remsi %30, %c20 : index
        %32 = arith.cmpi slt, %31, %c0 : index
        %33 = arith.addi %31, %c20 : index
        %34 = arith.select %32, %33, %31 : index
        %35 = arith.cmpi eq, %34, %c0 : index
        scf.if %35 {
          %40 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
          %41 = "polygeist.memref2pointer"(%40) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
          %42 = llvm.call @fprintf(%41, %18) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
        }
        %36 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %37 = "polygeist.memref2pointer"(%36) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %38 = affine.load %arg2[%arg3, %arg4] : memref<?x1200xf64>
        %39 = llvm.call @fprintf(%37, %16, %38) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
      }
    }
    %19 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %20 = "polygeist.memref2pointer"(%19) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %21 = llvm.mlir.addressof @str6 : !llvm.ptr
    %22 = llvm.getelementptr %21[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<17 x i8>
    %23 = llvm.call @fprintf(%20, %22, %12) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %24 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %25 = "polygeist.memref2pointer"(%24) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %26 = llvm.mlir.addressof @str7 : !llvm.ptr
    %27 = llvm.getelementptr %26[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %28 = llvm.call @fprintf(%25, %27) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    return
  }
}
