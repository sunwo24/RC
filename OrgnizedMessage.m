% Generate a message array with the elements from 1 to U
% Elements in GF(2^exp)
function [message, GF] = OrgnizedMessage(codeType, Parameter)

  % GF(2^gfExp)
  [gfExp, U] = BaseGF(codeType, Parameter);
  GF = GaloisField(gfExp);

  message = zeros(U);

  for i = 1 : U
    message(i) = i;
  end
