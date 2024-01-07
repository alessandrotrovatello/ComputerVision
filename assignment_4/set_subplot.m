%% Function to set the position and the dimensions of subplot
function [x,y] = set_subplot(windowWidth,windowHeight)

    % Get screen dimensions
    screenSize = get(0, 'ScreenSize');
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    % Calculate x and y coordinates to center the window
    x = (screenWidth - windowWidth) / 2;
    y = (screenHeight - windowHeight) / 2;

    % Set figure position
    set(gcf, 'Position', [x, y, windowWidth, windowHeight]);
end
