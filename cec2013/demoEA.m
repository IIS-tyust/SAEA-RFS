clear;

tic;

NP = 100; % population size
runs = 2; % number of independent runs for each function, should be set to 25
Max_FEs = 1000; % maximal number of FEs, should be set to 3e+06
global initial_flag; % the global flag used in test suite
format short e;

for func_num = 1:15

    %for overlapping function D = 905
    if func_num > 12 && func_num < 15
        D = 905; % dimensionality of the objective function.
    else
        D = 1000;
    end

    % Search Range
    if (func_num == 1 | func_num == 4 | func_num == 7 | func_num == 8 | func_num == 11 | func_num == 12 | func_num == 13 | func_num == 14 | func_num == 15 )
        lu = [-100*ones(1,D);100*ones(1,D)];
    end
    if (func_num == 2 | func_num == 5 | func_num == 9)
        lu = [-5*ones(1,D);5*ones(1,D)];
    end
    if (func_num == 3 | func_num == 6 | func_num == 10)
        lu = [-32*ones(1,D);32*ones(1,D)];
    end

   for run = 1:runs
      initial_flag = 0; % should set the flag to 0 for each run, each function
       XRRmin = repmat(lu(1, :), NP, 1);
       XRRmax = repmat(lu(2, :), NP ,1);
      pop = XRRmin + (XRRmax-XRRmin).*rand(NP, D);
      val = benchmark_func(pop, func_num); % fitness evaluation
      FEs = NP;
      while (FEs <= Max_FEs-NP)
         % random search, you should add your own method
         XRRmin = repmat(lu(1, :), NP, 1);
         XRRmax = repmat(lu(2, :), NP ,1);
         newpop = XRRmin + (XRRmax-XRRmin).*rand(NP, D);
         newval = benchmark_func(newpop, func_num);
         FEs = FEs + NP;
         
         index = (newval < val);
         val(index) = newval(index);
         pop(:, index) = newpop(:, index);
         
         % demo output, you should save your results to some files
         fprintf(1, 'func_num = %d, run = %d, FEs = %d\n', func_num, run, FEs);
         fprintf(1, 'min(val) = %e\n\n', min(val));
      end
   end

end

toc;
