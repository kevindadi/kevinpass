; ModuleID = 'deadlock.c'
source_filename = "deadlock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_mutexattr_t = type { i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@sleep_seconds = dso_local global i32 0, align 4
@food_lock = common dso_local global %union.pthread_mutex_t zeroinitializer, align 8
@chopstick = common dso_local global [5 x %union.pthread_mutex_t] zeroinitializer, align 16
@philo = common dso_local global [5 x i64] zeroinitializer, align 16
@.str = private unnamed_addr constant [55 x i8] c"Philosopher %d is done thinking and now ready to eat.\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"right \00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"left\00", align 1
@.str.3 = private unnamed_addr constant [25 x i8] c"Philosopher %d: eating.\0A\00", align 1
@.str.4 = private unnamed_addr constant [32 x i8] c"Philosopher %d is done eating.\0A\00", align 1
@food_on_table.food = internal global i32 50, align 4
@.str.5 = private unnamed_addr constant [37 x i8] c"Philosopher %d: got %s chopstick %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %7 = load i32, i32* %4, align 4
  %8 = icmp eq i32 %7, 2
  br i1 %8, label %9, label %14

9:                                                ; preds = %2
  %10 = load i8**, i8*** %5, align 8
  %11 = getelementptr inbounds i8*, i8** %10, i64 1
  %12 = load i8*, i8** %11, align 8
  %13 = call i32 @atoi(i8* %12) #4
  store i32 %13, i32* @sleep_seconds, align 4
  br label %14

14:                                               ; preds = %9, %2
  %15 = call i32 @pthread_mutex_init(%union.pthread_mutex_t* @food_lock, %union.pthread_mutexattr_t* null) #5
  store i32 0, i32* %6, align 4
  br label %16

16:                                               ; preds = %24, %14
  %17 = load i32, i32* %6, align 4
  %18 = icmp slt i32 %17, 5
  br i1 %18, label %19, label %27

19:                                               ; preds = %16
  %20 = load i32, i32* %6, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [5 x %union.pthread_mutex_t], [5 x %union.pthread_mutex_t]* @chopstick, i64 0, i64 %21
  %23 = call i32 @pthread_mutex_init(%union.pthread_mutex_t* %22, %union.pthread_mutexattr_t* null) #5
  br label %24

24:                                               ; preds = %19
  %25 = load i32, i32* %6, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %6, align 4
  br label %16

27:                                               ; preds = %16
  store i32 0, i32* %6, align 4
  br label %28

28:                                               ; preds = %39, %27
  %29 = load i32, i32* %6, align 4
  %30 = icmp slt i32 %29, 5
  br i1 %30, label %31, label %42

31:                                               ; preds = %28
  %32 = load i32, i32* %6, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [5 x i64], [5 x i64]* @philo, i64 0, i64 %33
  %35 = load i32, i32* %6, align 4
  %36 = sext i32 %35 to i64
  %37 = inttoptr i64 %36 to i8*
  %38 = call i32 @pthread_create(i64* %34, %union.pthread_attr_t* null, i8* (i8*)* @philosopher, i8* %37) #5
  br label %39

39:                                               ; preds = %31
  %40 = load i32, i32* %6, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %6, align 4
  br label %28

42:                                               ; preds = %28
  store i32 0, i32* %6, align 4
  br label %43

43:                                               ; preds = %52, %42
  %44 = load i32, i32* %6, align 4
  %45 = icmp slt i32 %44, 5
  br i1 %45, label %46, label %55

46:                                               ; preds = %43
  %47 = load i32, i32* %6, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [5 x i64], [5 x i64]* @philo, i64 0, i64 %48
  %50 = load i64, i64* %49, align 8
  %51 = call i32 @pthread_join(i64 %50, i8** null)
  br label %52

52:                                               ; preds = %46
  %53 = load i32, i32* %6, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %6, align 4
  br label %43

55:                                               ; preds = %43
  ret i32 0
}

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_init(%union.pthread_mutex_t*, %union.pthread_mutexattr_t*) #2

; Function Attrs: nounwind
declare !callback !2 dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @philosopher(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  %8 = load i8*, i8** %2, align 8
  %9 = ptrtoint i8* %8 to i32
  store i32 %9, i32* %3, align 4
  %10 = load i32, i32* %3, align 4
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @.str, i64 0, i64 0), i32 %10)
  %12 = load i32, i32* %3, align 4
  store i32 %12, i32* %6, align 4
  %13 = load i32, i32* %3, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %5, align 4
  %15 = load i32, i32* %5, align 4
  %16 = icmp eq i32 %15, 5
  br i1 %16, label %17, label %18

17:                                               ; preds = %1
  store i32 0, i32* %5, align 4
  br label %18

18:                                               ; preds = %17, %1
  br label %19

19:                                               ; preds = %28, %18
  %20 = call i32 @food_on_table()
  store i32 %20, i32* %7, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %42

22:                                               ; preds = %19
  %23 = load i32, i32* %3, align 4
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %28

25:                                               ; preds = %22
  %26 = load i32, i32* @sleep_seconds, align 4
  %27 = call i32 @sleep(i32 %26)
  br label %28

28:                                               ; preds = %25, %22
  %29 = load i32, i32* %3, align 4
  %30 = load i32, i32* %6, align 4
  call void @grab_chopstick(i32 %29, i32 %30, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
  %31 = load i32, i32* %3, align 4
  %32 = load i32, i32* %5, align 4
  call void @grab_chopstick(i32 %31, i32 %32, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0))
  %33 = load i32, i32* %3, align 4
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.3, i64 0, i64 0), i32 %33)
  %35 = load i32, i32* %7, align 4
  %36 = sub nsw i32 50, %35
  %37 = add nsw i32 %36, 1
  %38 = mul nsw i32 5000, %37
  %39 = call i32 @usleep(i32 %38)
  %40 = load i32, i32* %5, align 4
  %41 = load i32, i32* %6, align 4
  call void @down_chopsticks(i32 %40, i32 %41)
  br label %19

42:                                               ; preds = %19
  %43 = load i32, i32* %3, align 4
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.4, i64 0, i64 0), i32 %43)
  ret i8* null
}

declare dso_local i32 @pthread_join(i64, i8**) #3

declare dso_local i32 @printf(i8*, ...) #3

declare dso_local i32 @sleep(i32) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @grab_chopstick(i32 %0, i32 %1, i8* %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [5 x %union.pthread_mutex_t], [5 x %union.pthread_mutex_t]* @chopstick, i64 0, i64 %8
  %10 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* %9) #5
  %11 = load i32, i32* %4, align 4
  %12 = load i8*, i8** %6, align 8
  %13 = load i32, i32* %5, align 4
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 %11, i8* %12, i32 %13)
  ret void
}

declare dso_local i32 @usleep(i32) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @down_chopsticks(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds [5 x %union.pthread_mutex_t], [5 x %union.pthread_mutex_t]* @chopstick, i64 0, i64 %6
  %8 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* %7) #5
  %9 = load i32, i32* %4, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [5 x %union.pthread_mutex_t], [5 x %union.pthread_mutex_t]* @chopstick, i64 0, i64 %10
  %12 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* %11) #5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @food_on_table() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* @food_lock) #5
  %3 = load i32, i32* @food_on_table.food, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %0
  %6 = load i32, i32* @food_on_table.food, align 4
  %7 = add nsw i32 %6, -1
  store i32 %7, i32* @food_on_table.food, align 4
  br label %8

8:                                                ; preds = %5, %0
  %9 = load i32, i32* @food_on_table.food, align 4
  store i32 %9, i32* %1, align 4
  %10 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* @food_lock) #5
  %11 = load i32, i32* %1, align 4
  ret i32 %11
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_lock(%union.pthread_mutex_t*) #2

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_unlock(%union.pthread_mutex_t*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
!2 = !{!3}
!3 = !{i64 2, i64 3, i1 false}
