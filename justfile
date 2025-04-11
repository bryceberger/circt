default:
    @just build

alias b := build
alias t := test

build *args:
    ninja -C build {{ args }}

test:
    ninja -C build check-circt check-circt-integration

configure *args:
    cmake -B build -S llvm/llvm -G Ninja \
        -DCMAKE_LINKER_TYPE=MOLD \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DLLVM_TARGETS_TO_BUILD=host \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DLLVM_ENABLE_PROJECTS=mlir \
        -DLLVM_EXTERNAL_PROJECTS=circt \
        -DLLVM_EXTERNAL_CIRCT_SOURCE_DIR=. \
        -DCIRCT_SLANG_FRONTEND_ENABLED=ON \
        {{ args }}
