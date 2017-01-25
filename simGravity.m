function simGravity
    n = 2; 
    objets = zeros(n,7);
    objets(1,:) = [100,0,0,0,0,0,0];
    objets(2,:) = [0.1,-0.8,0,0,0,0,10];
    color = zeros(n,3);
    for i = 1:n
        color(i,:) = abs(sin(objets(i,1)/max(objets(:,1)) + [0 pi/3 2*pi/3]));
    end
    T = 620; dt = 0.01;
    for j = 1:T
        objets = calcMotion(objets,n,dt);
        scatter3(objets(:,2),objets(:,3),objets(:,4),10,color,'filled');
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
