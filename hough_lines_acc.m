function [H,H1, theta, rho] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    % Rows of H should correspond to values of rho, columns those of theta.

    p = inputParser();
    addParameter(p, 'RhoResolution', 1);
    %-100, -81, 20
    %20, 39, 20
    %-21,-40,20
    addParameter(p, 'Theta', linspace(-89, 90, 180));
    parse(p, varargin{:});

    rhoStep = p.Results.RhoResolution;
    theta = p.Results.Theta;

    dMax = sqrt((size(BW,1) - 1) ^ 2 + (size(BW,2) - 1) ^ 2);
    numRho = 2 * (ceil(dMax / rhoStep)) + 1;
    diagonal = rhoStep * ceil(dMax / rhoStep);% rho ranges from -diagonal to diagonal
    numTheta = length(theta);
    H = zeros(numRho, numTheta);
    H1 = zeros(numRho, numTheta);
    rho = -diagonal : diagonal;
    for i = 1 : size(BW,1)
        for j = 1 : size(BW,2)
            if (BW(i, j))
                for k = 1 : numTheta
                    temp = j * cos(theta(k) * pi / 180) + i * sin(theta(k) * pi / 180);
                    rowIndex = round((temp + diagonal) / rhoStep) + 1;
                    H(rowIndex, k) = H(rowIndex, k) + 1;                   
                end
            end    
            for k1 = 1 : numTheta
                temp1 = j * cos(theta(k1) * pi / 180) + i * sin(theta(k1) * pi / 180);
                rowIndex1 = round((temp1 + diagonal) / rhoStep) + 1;
                if rowIndex1 < size(H1,1) && k1< rowIndex1 < size(H1,2)
                    H1(rowIndex1, k1) = H1(rowIndex1, k1) + 1;   
                end
            end
        end
    end    
end
