local total = 0;
local drugs = {};
local drugs2 = {};
local contents = {};

local function AddToSolution(Name,table)
	drugs[Name]=table;
	drugs2[Name] = 0
	for i,v in pairs(table) do
		if contents[i] then
			contents[i] += v;
		end
	end
end
local function Add(Solution,Amount)
	drugs2[Solution] += Amount;
	total += Amount;
	for i,v in pairs(drugs[Solution]) do
		if contents[i] then
			contents[i] += drugs[Solution][i]*Amount
		else
			contents[i] = drugs[Solution][i]*Amount
		end
	end
end

local function PrintSolution()
	print''
	print("Total Mass:",total,"g")
	print("Solutions Used:")
	for i,v in pairs(drugs) do
		print(i,'-',drugs2[i]..'g',math.floor(((drugs2[i])/total)*10000+.5)/100,"%")
	end
	print''
	print('Chemical Breakdown: '..(total*1000)..' mg')
	for i,v in pairs(contents) do
		if not (v==0) then
			print(i,'-',(v*10)..'mg')
		end
	end
	print''
	print('Percent Breakdown: \n')
	for i,v in pairs(drugs) do
		for dname, dvalue in pairs(v) do
			if not (contents[dname] == 0) then
				contents[dname] = math.floor((contents[dname]/(total))*100+.5)/100 
				print(dname,contents[dname]..'%')
			end
		end
	end
	
end

AddToSolution("Distillate",{
d8thc = 93.43,

});
AddToSolution("BSCBD",{
cbd = 79.10,
cbn = 0.15,
cbg = 4.52,
thcv = 0.06,
cbdv = 1.74,
});

Add("Distillate",1)
Add("BSCBD",2.5)

PrintSolution()
