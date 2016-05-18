function message = RandMessage(gfExp, U)
 
    message = randi([0, (2^gfExp - 1)], 1, U);

end
