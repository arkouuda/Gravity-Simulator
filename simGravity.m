function simGravity
    n = 2; 
    obj = zeros(n,7);
    obj(1,:) = [3,1,0,0,0,0,-0.5];
    obj(2,:) = [3,-1,0,0,0,0,0.5];
    color = zeros(n,3);
    for i = 1:n
        color(i,:) = abs(sin(obj(i,1)/max(obj(:,1)) + [0 pi/3 2*pi/3]));
    end
    T = 620; dt = 0.01;
    for j = 1:T
        obj = calcMotion(obj,n,dt);
        scatter3(obj(:,2),obj(:,3),obj(:,4),10,color,'filled');
        whitebg('k');
        set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[]);
        grid on; grid minor;
        axis([-1 1 -1 1 -1 1]);
        pause(0.001);
    end
end
 
function obj = calcMotion(obj,n,dt)
    for i = 1:n
        obj(i,5:7) = calcVelocity(i);
        obj(i,2:4) = obj(i,2:4) + obj(i,5:7)*dt;
    end
    
    function velocity = calcVelocity(j)
        G = 1;
        velocity = obj(j,5:7);
        for k = 1:n
            if k ~= j
                distance = obj(k,2:4) - obj(j,2:4);
                velocity = velocity + G*dt*distance*obj(k,1)/(norm(distance)^3);
            end
        end
    end
end
