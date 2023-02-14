function MonkeyToggleRPVD(Case)
%For Case 1, it should pause rpvd,
%for case 0, it should resume rpvd...

actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
DA.SetTargetVal('Stim1.PauseTF',Case);
DA.CloseConnection;
close(actxfigure);
end
