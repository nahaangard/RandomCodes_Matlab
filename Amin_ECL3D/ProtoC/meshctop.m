function h = meshc(varargin)
    %MESHC  Combination mesh/contour plot.
    %   MESHC(...) is the same as MESH(...) except that a contour plot
    %   is drawn beneath the mesh.
    %
    %   Because CONTOUR does not handle irregularly spaced data, this
    %   routine only works for surfaces defined on a rectangular grid.
    %   The matrices or vectors X and Y define the axis limits only.
    %
    %   See also MESH, MESHZ.
    
    %   Clay M. Thompson 4-10-91
    %   Copyright 1984-2010 The MathWorks, Inc.
    %   $Revision: 5.8.4.5 $  $Date: 2011/04/04 22:59:08 $
    
    % First we check which HG plotting API should be used.
    if ishg2parent( varargin{:} )
        [~, cax, args] = parseplotapi(varargin{:},'-mfilename',mfilename);
        if nargout > 0
            h = meshcHGUsingMATLABClasses(cax, args{:});
        else
            meshcHGUsingMATLABClasses(cax, args{:});
        end
    else
        [cax, args] = axescheck(varargin{:});
        % Parse possible Axes input
        nargs = length(args);
        error(nargchk(1, 4, nargs, 'struct'));
        
        if nargs == 1  % Generate x, y matrices for surface z.
            z = args{1};
            [m, n] = size(z);
            [x, y] = meshgrid(1 : n, 1 : m);
        elseif nargs == 2
            z = args{1};
            c = args{2};
            [m, n] = size(z);
            [x, y] = meshgrid(1 : n, 1 : m);
        else
            [x, y, z] = deal(args{1 : 3});
            if nargs == 4
                c = args{4};
            end
        end
        
        if min(size(z)) == 1
            error(message('MATLAB:meshc:MatrixInput'));
        end
        
        % Determine state of system
        if isempty(cax)
            cax = gca;
        end
        next = lower(get(cax, 'NextPlot'));
        hold_state = ishold(cax);
        
        % Plot mesh.
        if nargs == 2 || nargs == 4
            hm = mesh(cax, x, y, z, c);
        else
            hm = mesh(cax, x, y, z);
        end
        
        hold(cax, 'on');
        
        a = get(cax, 'ZLim');
        
        % Always put contour below the plot.
        zpos = a(2);
        
        % Get D contour data
        [~, hh] = contour3(cax, x, y, z);
        
        % size zpos to match the data
        for i = 1 : length(hh)
            zz = get(hh(i), 'ZData');
            set(hh(i), 'ZData', zpos * ones(size(zz)));
        end
        
        if ~hold_state
            set(cax, 'NextPlot', next);
        end
        
        if nargout > 0
            h = [hm; hh(:)];
        end
    end
end
