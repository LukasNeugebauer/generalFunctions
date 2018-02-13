function [password]     = getPassword(server)
%function [password]     = getPassword(server)
%
%asks for input of a password for the specified server.
%this input serves only to remind you of the purpose of the password


if ~ischar(server)
    error('Please specify server as character');
end
%get password
password    = input(sprintf('Please enter the password for %s\n',server),'s');
%delete any possible output to the command window;
fprintf([repmat(char(8),1,length(password)+1),'\n']);
fprintf([repmat('*',1,length(password)),'\n']);

disp('Don''t forget to manually delete the password from the command history');

end