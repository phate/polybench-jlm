module attributes {} {
  llvm.mlir.global internal constant @str9("hz\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str8("ey\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str7("==END   DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str5("%0.2lf \00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str4("\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str3("ex\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str2("begin dump: %s\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @stderr() {addr_space = 0 : i32} : memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.mlir.global internal constant @str0("\00") {addr_space = 0 : i32}
  func.func @main(%arg0: i32, %arg1: memref<?xmemref<?xi8>>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 1.200000e+03 : f64
    %cst_0 = arith.constant 1.000000e+03 : f64
    %cst_1 = arith.constant 0.69999999999999996 : f64
    %cst_2 = arith.constant 5.000000e-01 : f64
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %c3_i32 = arith.constant 3 : i32
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c1200_i32 = arith.constant 1200 : i32
    %c1000_i32 = arith.constant 1000 : i32
    %alloc = memref.alloc() : memref<1000x1200xf64>
    %alloc_3 = memref.alloc() : memref<1000x1200xf64>
    %alloc_4 = memref.alloc() : memref<1000x1200xf64>
    %cast = memref.cast %alloc : memref<1000x1200xf64> to memref<?x1200xf64>
    %cast_5 = memref.cast %alloc_3 : memref<1000x1200xf64> to memref<?x1200xf64>
    %cast_6 = memref.cast %alloc_4 : memref<1000x1200xf64> to memref<?x1200xf64>
    affine.for %arg2 = 0 to 1000 {
      %1 = arith.index_cast %arg2 : index to i32
      %2 = arith.sitofp %1 : i32 to f64
      affine.for %arg3 = 0 to 1200 {
        %3 = arith.index_cast %arg3 : index to i32
        %4 = arith.addi %3, %c1_i32 : i32
        %5 = arith.sitofp %4 : i32 to f64
        %6 = arith.mulf %2, %5 : f64
        %7 = arith.divf %6, %cst_0 : f64
        affine.store %7, %alloc[%arg2, %arg3] : memref<1000x1200xf64>
        %8 = arith.addi %3, %c2_i32 : i32
        %9 = arith.sitofp %8 : i32 to f64
        %10 = arith.mulf %2, %9 : f64
        %11 = arith.divf %10, %cst : f64
        affine.store %11, %alloc_3[%arg2, %arg3] : memref<1000x1200xf64>
        %12 = arith.addi %3, %c3_i32 : i32
        %13 = arith.sitofp %12 : i32 to f64
        %14 = arith.mulf %2, %13 : f64
        %15 = arith.divf %14, %cst_0 : f64
        affine.store %15, %alloc_4[%arg2, %arg3] : memref<1000x1200xf64>
      }
    }
    affine.for %arg2 = 0 to 500 {
      %1 = arith.index_cast %arg2 : index to i32
      %2 = arith.sitofp %1 : i32 to f64
      affine.for %arg3 = 0 to 1200 {
        affine.store %2, %alloc_3[0, %arg3] : memref<1000x1200xf64>
      }
      affine.for %arg3 = 1 to 1000 {
        affine.for %arg4 = 0 to 1200 {
          %3 = affine.load %alloc_3[%arg3, %arg4] : memref<1000x1200xf64>
          %4 = affine.load %alloc_4[%arg3, %arg4] : memref<1000x1200xf64>
          %5 = affine.load %alloc_4[%arg3 - 1, %arg4] : memref<1000x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst_2 : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %alloc_3[%arg3, %arg4] : memref<1000x1200xf64>
        }
      }
      affine.for %arg3 = 0 to 1000 {
        affine.for %arg4 = 1 to 1200 {
          %3 = affine.load %alloc[%arg3, %arg4] : memref<1000x1200xf64>
          %4 = affine.load %alloc_4[%arg3, %arg4] : memref<1000x1200xf64>
          %5 = affine.load %alloc_4[%arg3, %arg4 - 1] : memref<1000x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst_2 : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %alloc[%arg3, %arg4] : memref<1000x1200xf64>
        }
      }
      affine.for %arg3 = 0 to 999 {
        affine.for %arg4 = 0 to 1199 {
          %3 = affine.load %alloc_4[%arg3, %arg4] : memref<1000x1200xf64>
          %4 = affine.load %alloc[%arg3, %arg4 + 1] : memref<1000x1200xf64>
          %5 = affine.load %alloc[%arg3, %arg4] : memref<1000x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = affine.load %alloc_3[%arg3 + 1, %arg4] : memref<1000x1200xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %alloc_3[%arg3, %arg4] : memref<1000x1200xf64>
          %10 = arith.subf %8, %9 : f64
          %11 = arith.mulf %10, %cst_1 : f64
          %12 = arith.subf %3, %11 : f64
          affine.store %12, %alloc_4[%arg3, %arg4] : memref<1000x1200xf64>
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
        func.call @print_array(%c1000_i32, %c1200_i32, %cast, %cast_5, %cast_6) : (i32, i32, memref<?x1200xf64>, memref<?x1200xf64>, memref<?x1200xf64>) -> ()
      }
    }
    memref.dealloc %alloc : memref<1000x1200xf64>
    memref.dealloc %alloc_3 : memref<1000x1200xf64>
    memref.dealloc %alloc_4 : memref<1000x1200xf64>
    return %c0_i32 : i32
  }
  func.func private @strcmp(memref<?xi8>, memref<?xi8>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>}
  func.func private @print_array(%arg0: i32, %arg1: i32, %arg2: memref<?x1200xf64>, %arg3: memref<?x1200xf64>, %arg4: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<internal>} {
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
    %12 = llvm.getelementptr %11[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %13 = llvm.call @fprintf(%8, %10, %12) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %14 = arith.index_cast %arg1 : i32 to index
    %15 = llvm.mlir.addressof @str5 : !llvm.ptr
    %16 = llvm.getelementptr %15[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<8 x i8>
    %17 = llvm.mlir.addressof @str4 : !llvm.ptr
    %18 = llvm.getelementptr %17[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i8>
    affine.for %arg5 = 0 to %0 {
      %45 = arith.muli %arg5, %0 : index
      affine.for %arg6 = 0 to %14 {
        %46 = arith.addi %arg6, %45 : index
        %47 = arith.remsi %46, %c20 : index
        %48 = arith.cmpi slt, %47, %c0 : index
        %49 = arith.addi %47, %c20 : index
        %50 = arith.select %48, %49, %47 : index
        %51 = arith.cmpi eq, %50, %c0 : index
        scf.if %51 {
          %56 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
          %57 = "polygeist.memref2pointer"(%56) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
          %58 = llvm.call @fprintf(%57, %18) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
        }
        %52 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %53 = "polygeist.memref2pointer"(%52) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %54 = affine.load %arg2[%arg5, %arg6] : memref<?x1200xf64>
        %55 = llvm.call @fprintf(%53, %16, %54) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
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
    %29 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %30 = "polygeist.memref2pointer"(%29) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %31 = llvm.mlir.addressof @str8 : !llvm.ptr
    %32 = llvm.getelementptr %31[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %33 = llvm.call @fprintf(%30, %10, %32) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    affine.for %arg5 = 0 to %0 {
      %45 = arith.muli %arg5, %0 : index
      affine.for %arg6 = 0 to %14 {
        %46 = arith.addi %arg6, %45 : index
        %47 = arith.remsi %46, %c20 : index
        %48 = arith.cmpi slt, %47, %c0 : index
        %49 = arith.addi %47, %c20 : index
        %50 = arith.select %48, %49, %47 : index
        %51 = arith.cmpi eq, %50, %c0 : index
        scf.if %51 {
          %56 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
          %57 = "polygeist.memref2pointer"(%56) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
          %58 = llvm.call @fprintf(%57, %18) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
        }
        %52 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %53 = "polygeist.memref2pointer"(%52) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %54 = affine.load %arg3[%arg5, %arg6] : memref<?x1200xf64>
        %55 = llvm.call @fprintf(%53, %16, %54) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
      }
    }
    %34 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %35 = "polygeist.memref2pointer"(%34) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %36 = llvm.call @fprintf(%35, %22, %32) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %37 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %38 = "polygeist.memref2pointer"(%37) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %39 = llvm.mlir.addressof @str9 : !llvm.ptr
    %40 = llvm.getelementptr %39[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<3 x i8>
    %41 = llvm.call @fprintf(%38, %10, %40) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    affine.for %arg5 = 0 to %0 {
      %45 = arith.muli %arg5, %0 : index
      affine.for %arg6 = 0 to %14 {
        %46 = arith.addi %arg6, %45 : index
        %47 = arith.remsi %46, %c20 : index
        %48 = arith.cmpi slt, %47, %c0 : index
        %49 = arith.addi %47, %c20 : index
        %50 = arith.select %48, %49, %47 : index
        %51 = arith.cmpi eq, %50, %c0 : index
        scf.if %51 {
          %56 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
          %57 = "polygeist.memref2pointer"(%56) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
          %58 = llvm.call @fprintf(%57, %18) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
        }
        %52 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
        %53 = "polygeist.memref2pointer"(%52) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
        %54 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
        %55 = llvm.call @fprintf(%53, %16, %54) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
      }
    }
    %42 = llvm.load %1 : !llvm.ptr -> memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>
    %43 = "polygeist.memref2pointer"(%42) : (memref<?x!llvm.struct<(i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, array<1 x i8>, ptr, i64, ptr, ptr, ptr, ptr, i64, i32, array<20 x i8>)>>) -> !llvm.ptr
    %44 = llvm.call @fprintf(%43, %22, %40) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    return
  }
}
