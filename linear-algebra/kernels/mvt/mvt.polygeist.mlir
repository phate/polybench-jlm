#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (2000, d0 * 32 + 32)>
module attributes {} {
  llvm.mlir.global internal constant @str8("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str7("x2\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("x1\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @str0("\00") {addr_space = 0 : i32}
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 2.000000e+03 : f64
    %c1_i32 = arith.constant 1 : i32
    %c3_i32 = arith.constant 3 : i32
    %c4_i32 = arith.constant 4 : i32
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c2000_i32 = arith.constant 2000 : i32
    %alloc = memref.alloc() : memref<2000xf64>
    %alloc_0 = memref.alloc() : memref<2000xf64>
    %cast = memref.cast %alloc : memref<2000xf64> to memref<?xf64>
    %cast_1 = memref.cast %alloc_0 : memref<2000xf64> to memref<?xf64>
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        %1 = arith.index_cast %arg3 : index to i32
        %2 = arith.addi %1, %c1_i32 : i32
        %3 = arith.remsi %2, %c2000_i32 : i32
        %4 = arith.sitofp %3 : i32 to f64
        %5 = arith.divf %4, %cst : f64
        affine.store %5, %alloc_0[%arg3] : memref<2000xf64>
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = 0 to 63 {
        affine.for %arg4 = #map(%arg3) to min #map1(%arg3) {
          affine.for %arg5 = #map(%arg2) to min #map1(%arg2) {
            %1 = affine.load %alloc_0[%arg5] : memref<2000xf64>
            %2 = arith.index_cast %arg5 : index to i32
            %3 = arith.index_cast %arg4 : index to i32
            %4 = arith.muli %3, %2 : i32
            %5 = arith.remsi %4, %c2000_i32 : i32
            %6 = arith.sitofp %5 : i32 to f64
            %7 = arith.divf %6, %cst : f64
            %8 = arith.addi %3, %c4_i32 : i32
            %9 = arith.remsi %8, %c2000_i32 : i32
            %10 = arith.sitofp %9 : i32 to f64
            %11 = arith.divf %10, %cst : f64
            %12 = arith.mulf %7, %11 : f64
            %13 = arith.addf %1, %12 : f64
            affine.store %13, %alloc_0[%arg5] : memref<2000xf64>
          }
        }
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2) {
        %1 = arith.index_cast %arg3 : index to i32
        %2 = arith.remsi %1, %c2000_i32 : i32
        %3 = arith.sitofp %2 : i32 to f64
        %4 = arith.divf %3, %cst : f64
        affine.store %4, %alloc[%arg3] : memref<2000xf64>
      }
    }
    affine.for %arg2 = 0 to 63 {
      affine.for %arg3 = 0 to 63 {
        affine.for %arg4 = #map(%arg3) to min #map1(%arg3) {
          affine.for %arg5 = #map(%arg2) to min #map1(%arg2) {
            %1 = affine.load %alloc[%arg5] : memref<2000xf64>
            %2 = arith.index_cast %arg5 : index to i32
            %3 = arith.index_cast %arg4 : index to i32
            %4 = arith.muli %2, %3 : i32
            %5 = arith.remsi %4, %c2000_i32 : i32
            %6 = arith.sitofp %5 : i32 to f64
            %7 = arith.divf %6, %cst : f64
            %8 = arith.addi %3, %c3_i32 : i32
            %9 = arith.remsi %8, %c2000_i32 : i32
            %10 = arith.sitofp %9 : i32 to f64
            %11 = arith.divf %10, %cst : f64
            %12 = arith.mulf %7, %11 : f64
            %13 = arith.addf %1, %12 : f64
            affine.store %13, %alloc[%arg5] : memref<2000xf64>
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
        func.call @print_array(%c2000_i32, %cast, %cast_1) : (i32, memref<?xf64>, memref<?xf64>) -> ()
      }
    }
    memref.dealloc %alloc : memref<2000xf64>
    memref.dealloc %alloc_0 : memref<2000xf64>
    return %c0_i32 : i32
  }
  func.func private @strcmp(memref<?xi8>, memref<?xi8>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>}
  func.func private @print_array(%arg0: i32, %arg1: memref<?xf64>, %arg2: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<internal>} {
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %0 = llvm.mlir.addressof @stderr : !llvm.ptr
    %1 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %2 = "polygeist.memref2pointer"(%1) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %3 = llvm.mlir.addressof @str1 : !llvm.ptr
    %4 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %5 = llvm.call @fprintf(%2, %4) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %6 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %7 = "polygeist.memref2pointer"(%6) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %8 = llvm.mlir.addressof @str2 : !llvm.ptr
    %9 = llvm.getelementptr %8[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<15 x i8>
    %10 = llvm.mlir.addressof @str3 : !llvm.ptr
    %11 = llvm.getelementptr %10[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %12 = llvm.call @fprintf(%7, %9, %11) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %13 = arith.index_cast %arg0 : i32 to index
    %14 = llvm.mlir.addressof @str5 : !llvm.ptr
    %15 = llvm.getelementptr %14[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<8 x i8>
    %16 = llvm.mlir.addressof @str4 : !llvm.ptr
    %17 = llvm.getelementptr %16[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    affine.for %arg3 = 0 to %13 {
      %36 = arith.remsi %arg3, %c20 : index
      %37 = arith.cmpi slt, %36, %c0 : index
      %38 = arith.addi %36, %c20 : index
      %39 = arith.select %37, %38, %36 : index
      %40 = arith.cmpi eq, %39, %c0 : index
      scf.if %40 {
        %45 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %46 = "polygeist.memref2pointer"(%45) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %47 = llvm.call @fprintf(%46, %17) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
      }
      %41 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
      %42 = "polygeist.memref2pointer"(%41) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
      %43 = affine.load %arg1[%arg3] : memref<?xf64>
      %44 = llvm.call @fprintf(%42, %15, %43) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    }
    %18 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %19 = "polygeist.memref2pointer"(%18) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %20 = llvm.mlir.addressof @str6 : !llvm.ptr
    %21 = llvm.getelementptr %20[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<17 x i8>
    %22 = llvm.call @fprintf(%19, %21, %11) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %23 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %24 = "polygeist.memref2pointer"(%23) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %25 = llvm.mlir.addressof @str7 : !llvm.ptr
    %26 = llvm.getelementptr %25[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %27 = llvm.call @fprintf(%24, %9, %26) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    affine.for %arg3 = 0 to %13 {
      %36 = arith.remsi %arg3, %c20 : index
      %37 = arith.cmpi slt, %36, %c0 : index
      %38 = arith.addi %36, %c20 : index
      %39 = arith.select %37, %38, %36 : index
      %40 = arith.cmpi eq, %39, %c0 : index
      scf.if %40 {
        %45 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %46 = "polygeist.memref2pointer"(%45) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %47 = llvm.call @fprintf(%46, %17) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
      }
      %41 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
      %42 = "polygeist.memref2pointer"(%41) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
      %43 = affine.load %arg2[%arg3] : memref<?xf64>
      %44 = llvm.call @fprintf(%42, %15, %43) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    }
    %28 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %29 = "polygeist.memref2pointer"(%28) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %30 = llvm.call @fprintf(%29, %21, %26) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %31 = llvm.load %0 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %32 = "polygeist.memref2pointer"(%31) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %33 = llvm.mlir.addressof @str8 : !llvm.ptr
    %34 = llvm.getelementptr %33[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<23 x i8>
    %35 = llvm.call @fprintf(%32, %34) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    return
  }
}
