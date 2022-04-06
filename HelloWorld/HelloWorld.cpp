//=============================================================================
// FILE:
//    HelloWorld.cpp
//
// DESCRIPTION:
//    遍历所有在模块中的函数，打印它们的名字和参数通过stderr.严格来讲，这是一个分析pass，
//    如这个函数并没有被修改. 所有的分析Pass必须实现print方法，此次使用err
//
// USAGE:
//    1. 层次化插件管理器
//      opt -load libHelloWorld.dylib -legacy-hello-world -disable-output `\`
//        <input-llvm-file>
//    2. 新插件管理器
//      opt -load-pass-plugin=libHelloWorld.dylib -passes="hello-world" `\`
//        -disable-output <input-llvm-file>
//
//
// License: MIT
//=============================================================================
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

//-----------------------------------------------------------------------------
// HelloWorld implementation
//-----------------------------------------------------------------------------
// 不需要向外部暴露借口，尽在匿名类内部实现
namespace {

// 这个方法实现这个Pass做了什么
void visitor(Function &F) {
    errs() << "(Kevin-Petri) Function from: "<< F.getName() << "\n";
    errs() << "(Kevin-Petri)   number of arguments: " << F.arg_size() << "\n";
}

// class Kevin : PassInfoMixin<Hll

  // 新插件管理器实现
struct HelloWorld : PassInfoMixin<HelloWorld> {
  // 主entry点, 将IR单元代入Pass on (&F) and the
  // corresponding pass manager (to be queried if need be)
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    visitor(F);
    return PreservedAnalyses::all();
  }

  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};

// Legacy PM implementation
struct LegacyHelloWorld : public FunctionPass {
  static char ID;
  LegacyHelloWorld() : FunctionPass(ID) {}
  // Main entry point - the name conveys what unit of IR this is to be run on.
  bool runOnFunction(Function &F) override {
    visitor(F);
    // Doesn't modify the input unit of IR, hence 'false'
    return false;
  }
};
} // namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloWorld", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hello-world") {
                    FPM.addPass(HelloWorld());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}

//-----------------------------------------------------------------------------
// Legacy PM Registration
//-----------------------------------------------------------------------------
// The address of this variable is used to uniquely identify the pass. The
// actual value doesn't matter.
char LegacyHelloWorld::ID = 0;

// This is the core interface for pass plugins. It guarantees that 'opt' will
// recognize LegacyHelloWorld when added to the pass pipeline on the command
// line, i.e.  via '--legacy-hello-world'
static RegisterPass<LegacyHelloWorld>
    X("legacy-hello-world", "Hello World Pass",
      true, // This pass doesn't modify the CFG => true
      false // This pass is not a pure analysis pass => false
    );
