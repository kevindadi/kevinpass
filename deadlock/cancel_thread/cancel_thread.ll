; ModuleID = 'cancel_thread.ll'
source_filename = "cancel_thread.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_mutexattr_t = type { i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@m = common dso_local global %union.pthread_mutex_t zeroinitializer, align 8
@.str = private unnamed_addr constant [13 x i8] c"\E5\A5\87\E6\95\B0\EF\BC\9A%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"\E5\81\B6\E6\95\B0\EF\BC\9A%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"\E5\A4\96\E9\83\A8\E5\BC\BA\E5\88\B6\E5\81\9C\E6\AD\A2todd\E7\BA\BF\E7\A8\8B\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @runodd(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  store i32 0, i32* %3, align 4
  store i32 1, i32* %3, align 4
  br label %4

4:                                                ; preds = %10, %1
  %5 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* @m) #3
  %6 = load i32, i32* %3, align 4
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0), i32 %6)
  %8 = call i32 (i32, ...) bitcast (i32 (...)* @usleep to i32 (i32, ...)*)(i32 100)
  %9 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* @m) #3
  br label %10

10:                                               ; preds = %4
  %11 = load i32, i32* %3, align 4
  %12 = add nsw i32 %11, 2
  store i32 %12, i32* %3, align 4
  br label %4
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_lock(%union.pthread_mutex_t*) #1

declare dso_local i32 @printf(i8*, ...) #2

declare dso_local i32 @usleep(...) #2

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_unlock(%union.pthread_mutex_t*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @runeven(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  store i32 0, i32* %3, align 4
  store i32 0, i32* %3, align 4
  br label %4

4:                                                ; preds = %10, %1
  %5 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* @m) #3
  %6 = load i32, i32* %3, align 4
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0), i32 %6)
  %8 = call i32 (i32, ...) bitcast (i32 (...)* @usleep to i32 (i32, ...)*)(i32 100)
  %9 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* @m) #3
  br label %10

10:                                               ; preds = %4
  %11 = load i32, i32* %3, align 4
  %12 = add nsw i32 %11, 2
  store i32 %12, i32* %3, align 4
  br label %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i64, align 8
  %2 = alloca i64, align 8
  %3 = call i32 @pthread_mutex_init(%union.pthread_mutex_t* @m, %union.pthread_mutexattr_t* null) #3
  %4 = call i32 @pthread_create(i64* %1, %union.pthread_attr_t* null, i8* (i8*)* @runodd, i8* null) #3
  %5 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @runeven, i8* null) #3
  %6 = call i32 (i32, ...) bitcast (i32 (...)* @sleep to i32 (i32, ...)*)(i32 5)
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2, i64 0, i64 0))
  %8 = load i64, i64* %1, align 8
  %9 = call i32 @pthread_cancel(i64 %8)
  %10 = load i64, i64* %1, align 8
  %11 = call i32 @pthread_join(i64 %10, i8** null)
  %12 = load i64, i64* %2, align 8
  %13 = call i32 @pthread_join(i64 %12, i8** null)
  %14 = call i32 @pthread_mutex_destroy(%union.pthread_mutex_t* @m) #3
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_init(%union.pthread_mutex_t*, %union.pthread_mutexattr_t*) #1

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

declare dso_local i32 @sleep(...) #2

declare dso_local i32 @pthread_cancel(i64) #2

declare dso_local i32 @pthread_join(i64, i8**) #2

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_destroy(%union.pthread_mutex_t*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}
