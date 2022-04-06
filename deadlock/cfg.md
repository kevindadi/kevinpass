# 生成IR文件 bitcode
`clang -S -emit-llvm source.c -o source.ll`
# 生成调用控制流图
`opt -dot-callgraph  source.ll` # 生成dot文件
# 生成图片
`dot callgraph.dot -Tpng -o callgraph.png`

# 生成函数控制流图
`opt -dot-cfg  source.ll` # 生成dot文件
`dot cfg.main.dot -Tpng -o cfg.main.png` # 生成图片

# 这两种命令是直接将生成的AST输出在shell中。如果file中只是一个函数片段，其中的某些变量或者函数并没有在函数内部定义，那么就会报错。这时就无法正常输出结果，而是会将error和warning报出来。
`clang -Xclang -fsyntax-only -ast-dump file` 
`clang -emit-ast file`
# 如果不加 -fsyntax-only，会输出些结果。在这些结果里，会有些statement被忽略掉，
`clang -Xclang -ast-dump file`
