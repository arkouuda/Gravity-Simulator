function simGravity
    n = 2; 
    objects = zeros(n,7);
    objects(1,:) = [10,0,0,0,0,0,-0.35];
    objects(2,:) = [1,-0.8,0,0,0,0,3.5];
    color = zeros(n,3);
    for i = 1:n
        color(i,:) = abs(sin(objects(i,1)/max(objects(:,1)) + [0 pi/3 2*pi/3]));
    end
    T = 620; dt = 0.01;
    for j = 1:T
        objects = calcMotion(objects,n,dt);
        scatter3(objects(:,2),objects(:,3),objects(:,4),10,color,'filled');
        whitebg('k');
        set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[]);
        grid on; grid minor;
        axis([-1 1 -1 1 -1 1]);
        pause(0.001);
    end
end
 
function objects = calcMotion(objects,n,dt)
    for i = 1:n
        objects(i,5:7) = calcVelocity(i);
        objects(i,2:4) = objects(i,2:4) + objects(i,5:7)*dt;
    end
    
    function velocity = calcVelocity(j)
        G = 1;
        velocity = objects(j,5:7);
        for k = 1:n
            if k ~= j
                distance = objects(k,2:4) - objects(j,2:4);
                velocity = velocity + G*dt*distance*objects(k,1)/(norm(distance)^3);
            end
        end
    end
end
