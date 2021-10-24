-- CMD C:\Users\whatd\Documents\Lua programs>lua newdrug.lua
-- Drug Calculator
-- v2.0
--  ~ Solution Percents -ne
--  + Solution Cost ~ye
--  + Active solution / mg ~eh
--  + In-Active solution / mg ~eh
--  + Recommended price for resale ~yeh
--  ? Solution Conversions (i.e. Batchs w/ drops) ~ye
--		~ dosage / drop and mass used into total dosage ~ne
--
--
--

-- to do:
-- match string length and pixel size for dose/mg to line up in middle
math.randomseed(os.time());
function d(...)
	print(...)
end
function ToTincture(Drog,ml)
	
	return {Drop = {},Dropper = {}}
end

function RandomString_Gen(Length, List)
	local Batch_Sigs = {'DEX'};
	math.randomseed(os.time());
	local ret = '';
	for i=1,Length do
		local dub = math.random(1,string.len(List));
		ret = ret .. string.upper(List:sub(dub,dub));
	end
	
	return (Batch_Sigs[math.random(1,2)]..' - '..ret)
end
local solution = {
	print('Batch:',RandomString_Gen(8,'jvxoudrtyqcmk'));
	v = 0; -- ml/g
	cost = 0;
	startup = 0;
	costs = {};
	Content = {};
	SetCost = function(self,cost)
		self.cost = cost;
		self.startup = cost;
	end,
	Add = function(solution,Name, Cost, Proportions, Volume)
		solution.cost = solution.cost + (Cost*(Volume)); -- .15 for lost distillate
		solution.v = solution.v + Volume;
		for index,value in pairs(Proportions) do
			solution.costs[index] = (Cost*Volume)*(Proportions[index]/100); -- = price per ml
			if solution.Content[index] then
				solution.Content[index] = solution.Content[index] + (value * (Volume*10));
			else
				solution.Content[index] = value * Volume*10;
			end
		end;
	end,
	Print = function(self,	arg)
		for i,v in pairs(self.costs) do
			self.costs[i] = (math.floor((v / self.v)*100+.5)/100);
		end
		if arg == 1 then -- Print Contents
			print"\nContents\n"
			for i,v in pairs(self.Content) do
				print(i,v.." mg");
			end
			print''
		elseif arg == 2 then -- Print Contents Cart
			print"\nCart Contents (mg/ml)\n"
			for i,v in pairs(self.Content) do
				print(i,(math.floor((v/self.v)*100)/100).." mg");
			end
			print''
		elseif arg == 3 then -- Print Contents Tincture
			print"\nTincture Contents  mg(ml/drop)\n"
			for i,v in pairs(self.Content) do
				if i ~= 'Filler' then
					print('',i,(math.floor((v/self.v)*10)/10)..'/'..(math.floor(((v/self.v)*10)*.05+.5)/10));
				end
			end
			print''
		end
		print'================'
		print('Startup Cost  =  '..self.startup, '$');
		print('Total Cost  =   '..math.floor((self.cost)*10)/10,'$\n================\n');
		print'Suggested Retail:'
		local markup = math.floor((self.cost+.599)*2.5*10)/10;
		if (math.floor(markup/10+.5)*10 > markup) then
			markup = math.floor(markup/10+.5)*10; 
		else -- Yes I markup after I markup. part of markups are for lost distillate in transfer, incorrect ratios, and time
			markup = (math.floor(markup/10)*10+5);
		end
		print(markup,'$')
		print'\n================'
		
	end
}

local Solution = setmetatable(solution,{
	__index = function(self,prop)
        if not self.Content[prop] or (self.Content[prop] == 0) then
            return 0
        else
		 -- Name In_Solution / 1g(ml)    name_Percent
			print('',prop,math.floor(self.Content[prop])..' / '..math.floor((self.Content[prop]/self.v)*100)/100,(math.floor(((self.Content[prop]*100)/self.v)+.5)/1000)..'%')
            return print('','',(math.floor(self.costs[prop]/self.v*100000)/100000)..'$');
        end
    end,
})
function MajorNoids()
	local a;
	print' Active Contents:\n'
	a = Solution['d9thc'];
	a = Solution['d9thca'];
	a = Solution['d8thc'];
	a = Solution['d8thco'];
	a = Solution['d9thco'];
	a = Solution['d10thc'];
	a = Solution['hhc-9s'];
	a = Solution['hhc-9r'];
	a = Solution['hhc-9u'];
	print' Inactive Contents:\n'
	a = Solution.cbd;
	a = Solution.cbdv
	a = Solution.cbn;
	a = Solution.cbg;
	a = Solution.cbt;
	a = Solution.cbc;
	a = Solution.cbe;
	a = Solution.cbl;
	a = Solution.terps;
end
Solution:SetCost(3.6); -- Set starting cost (i.e. Cartridge cost per(1), or Tincture bottle glass per(1)
Solution:Add('Terps',20,{['terps']=100},.05);
--Solution:Add('GVB-Biopharma Full Spectrum CBD Distillate',2.7,{['cbd']=86.5,['d9thc']=.15,['cbdv']=.7,['cbt']=2.3},2);
Solution:Add('Loud house hemp Delta-8',1.6,{['d8thc']=93,},.95)
--Solution:Add('70% Ethanol',.08,{Filler=100},54);
Solution:Print(2);
MajorNoids()
--print(Solution.cbd)





 -- .8g d8	
 -- .15g FSE
 -- .05g terps
