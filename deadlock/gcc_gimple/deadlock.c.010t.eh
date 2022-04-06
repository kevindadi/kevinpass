
;; Function main (main, funcdef_no=6, decl_uid=3839, cgraph_uid=6, symbol_order=10)

main (int argn, char * * argv)
{
  int i;
  int D.3878;

  gimple_cond <eq_expr, argn, 2, <D.3876>, <D.3877>>
  gimple_label <<D.3876>>
  gimple_assign <pointer_plus_expr, _1, argv, 8, NULL>
  gimple_assign <mem_ref, _2, *_1, NULL, NULL>
  gimple_call <atoi, _3, _2>
  gimple_assign <ssa_name, sleep_seconds, _3, NULL, NULL>
  gimple_label <<D.3877>>
  gimple_call <pthread_mutex_init, NULL, &food_lock, 0B>
  gimple_assign <integer_cst, i, 0, NULL, NULL>
  gimple_goto <<D.3843>>
  gimple_label <<D.3842>>
  gimple_assign <addr_expr, _4, &chopstick[i], NULL, NULL>
  gimple_call <pthread_mutex_init, NULL, _4, 0B>
  gimple_assign <plus_expr, i, i, 1, NULL>
  gimple_label <<D.3843>>
  gimple_cond <le_expr, i, 4, <D.3842>, <D.3844>>
  gimple_label <<D.3844>>
  gimple_assign <integer_cst, i, 0, NULL, NULL>
  gimple_goto <<D.3846>>
  gimple_label <<D.3845>>
  gimple_assign <nop_expr, _5, i, NULL, NULL>
  gimple_assign <nop_expr, _6, _5, NULL, NULL>
  gimple_assign <addr_expr, _7, &philo[i], NULL, NULL>
  gimple_call <pthread_create, NULL, _7, 0B, philosopher, _6>
  gimple_assign <plus_expr, i, i, 1, NULL>
  gimple_label <<D.3846>>
  gimple_cond <le_expr, i, 4, <D.3845>, <D.3847>>
  gimple_label <<D.3847>>
  gimple_assign <integer_cst, i, 0, NULL, NULL>
  gimple_goto <<D.3849>>
  gimple_label <<D.3848>>
  gimple_assign <array_ref, _8, philo[i], NULL, NULL>
  gimple_call <pthread_join, NULL, _8, 0B>
  gimple_assign <plus_expr, i, i, 1, NULL>
  gimple_label <<D.3849>>
  gimple_cond <le_expr, i, 4, <D.3848>, <D.3850>>
  gimple_label <<D.3850>>
  gimple_assign <integer_cst, D.3878, 0, NULL, NULL>
  gimple_goto <<D.3879>>
  gimple_assign <integer_cst, D.3878, 0, NULL, NULL>
  gimple_goto <<D.3879>>
  gimple_label <<D.3879>>
  gimple_return <D.3878 NULL>
}



;; Function philosopher (philosopher, funcdef_no=7, decl_uid=3824, cgraph_uid=7, symbol_order=11)

philosopher (void * num)
{
  int f;
  int right_chopstick;
  int left_chopstick;
  int i;
  int id;
  void * D.3884;

  gimple_assign <nop_expr, num.0_1, num, NULL, NULL>
  gimple_assign <nop_expr, id, num.0_1, NULL, NULL>
  gimple_call <printf, NULL, "Philosopher %d is done thinking and now ready to eat.\n", id>
  gimple_assign <var_decl, right_chopstick, id, NULL, NULL>
  gimple_assign <plus_expr, left_chopstick, id, 1, NULL>
  gimple_cond <eq_expr, left_chopstick, 5, <D.3880>, <D.3881>>
  gimple_label <<D.3880>>
  gimple_assign <integer_cst, left_chopstick, 0, NULL, NULL>
  gimple_label <<D.3881>>
  gimple_goto <<D.3860>>
  gimple_label <<D.3859>>
  gimple_cond <eq_expr, id, 1, <D.3882>, <D.3883>>
  gimple_label <<D.3882>>
  gimple_assign <var_decl, sleep_seconds.1_2, sleep_seconds, NULL, NULL>
  gimple_assign <nop_expr, sleep_seconds.2_3, sleep_seconds.1_2, NULL, NULL>
  gimple_call <sleep, NULL, sleep_seconds.2_3>
  gimple_label <<D.3883>>
  gimple_call <grab_chopstick, NULL, id, right_chopstick, "right ">
  gimple_call <grab_chopstick, NULL, id, left_chopstick, "left">
  gimple_call <printf, NULL, "Philosopher %d: eating.\n", id>
  gimple_assign <minus_expr, _4, 51, f, NULL>
  gimple_assign <mult_expr, _5, _4, 5000, NULL>
  gimple_assign <nop_expr, _6, _5, NULL, NULL>
  gimple_call <usleep, NULL, _6>
  gimple_call <down_chopsticks, NULL, left_chopstick, right_chopstick>
  gimple_label <<D.3860>>
  gimple_call <food_on_table, f>
  gimple_cond <ne_expr, f, 0, <D.3859>, <D.3861>>
  gimple_label <<D.3861>>
  gimple_call <printf, NULL, "Philosopher %d is done eating.\n", id>
  gimple_assign <integer_cst, D.3884, 0B, NULL, NULL>
  gimple_goto <<D.3885>>
  gimple_label <<D.3885>>
  gimple_return <D.3884 NULL>
}



;; Function food_on_table (food_on_table, funcdef_no=8, decl_uid=3832, cgraph_uid=8, symbol_order=12)

food_on_table ()
{
  int myfood;
  static int food = 50;
  int D.3888;

  gimple_call <pthread_mutex_lock, NULL, &food_lock>
  gimple_assign <var_decl, food.3_1, food, NULL, NULL>
  gimple_cond <gt_expr, food.3_1, 0, <D.3886>, <D.3887>>
  gimple_label <<D.3886>>
  gimple_assign <var_decl, food.4_2, food, NULL, NULL>
  gimple_assign <plus_expr, _3, food.4_2, -1, NULL>
  gimple_assign <ssa_name, food, _3, NULL, NULL>
  gimple_label <<D.3887>>
  gimple_assign <var_decl, myfood, food, NULL, NULL>
  gimple_call <pthread_mutex_unlock, NULL, &food_lock>
  gimple_assign <var_decl, D.3888, myfood, NULL, NULL>
  gimple_goto <<D.3889>>
  gimple_label <<D.3889>>
  gimple_return <D.3888 NULL>
}



;; Function grab_chopstick (grab_chopstick, funcdef_no=9, decl_uid=3828, cgraph_uid=9, symbol_order=13)

grab_chopstick (int phil, int c, char * hand)
{
  gimple_assign <addr_expr, _1, &chopstick[c], NULL, NULL>
  gimple_call <pthread_mutex_lock, NULL, _1>
  gimple_call <printf, NULL, "Philosopher %d: got %s chopstick %d\n", phil, hand, c>
  gimple_return <NULL NULL>
}



;; Function down_chopsticks (down_chopsticks, funcdef_no=10, decl_uid=3831, cgraph_uid=10, symbol_order=14)

down_chopsticks (int c1, int c2)
{
  gimple_assign <addr_expr, _1, &chopstick[c1], NULL, NULL>
  gimple_call <pthread_mutex_unlock, NULL, _1>
  gimple_assign <addr_expr, _2, &chopstick[c2], NULL, NULL>
  gimple_call <pthread_mutex_unlock, NULL, _2>
  gimple_return <NULL NULL>
}


