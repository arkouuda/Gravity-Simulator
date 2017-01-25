function simGravity
    n = 3; 
    T = 500; dt = 0.01;
    obj = zeros(n,7);
    obj(1,:) = [1.5,1,1,0,-0.6,0,0.8];
    obj(2,:) = [1,-1,0,0,0.6,-0.7,0];
    obj(3,:) = [2,0,1,0,0.5,0,0.5];
    for k = 1:T
        obj = calcMotion(obj,n,dt);
        scatter3(obj(:,2),obj(:,3),obj(:,4),'o','filled','MarkerEdgeColor','k');
        whitebg('k');
        set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[]);
        axis([-5 5 -5 5 -5 5]);
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
        for k = 1:n
            if k ~= j
                velocity = obj(j,5:7);
                distance = obj(k,2:4) - obj(j,2:4);
                velocity = velocity + G*dt*distance*obj(k,1)/(norm(distance)^3);
            end
        end
    end
end
