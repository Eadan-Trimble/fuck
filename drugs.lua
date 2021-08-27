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
	print("Total Mass:",total,"g","\n")
	print("Solutions Used:")
	for i,v in pairs(drugs) do
		if drugs2[i] > 0 then
			print(i,'-',drugs2[i]..'g',math.floor(((drugs2[i])/total)*10000+.5)/100,"%")
		end
	end
	print''
	print('Percent Breakdown: \n')
	print("THC(thca * .877 + thc)")
	print("CBD(cbda * .877 + cbd\n")
	if contents['thca'] then
		contents['d9thc'] += contents['thca']*.877;
		contents['thca']=0
	end
	if contents['cbda'] then
		contents['cbd'] += contents['cbda']*.877;
		contents['cbda']=0
	end
	
	for i,v in pairs(contents) do
		if v>0 then
			print(i,math.floor((v/(total))*100+.5)/100,"%" )
		end
	end
	
end

AddToSolution("d8-7-10-21",{
	d8thc = 93.01,
	d9thc = .15,
	thca = 1,
})
AddToSolution("d8-Laughing_buddha",{
	d8thc = 94.900,
})
AddToSolution("freshbro",{
d8thc = 75.072,
});
AddToSolution("BSCBD",{
cbd = 88.26,
cbn = .22,
cbg = 7.16,
thcv = .08,
cbdv = .57
});

AddToSolution("BS-7-16-21",{
cbd = 90.3854,
cbdv = 1.6097,
cbg = 4.0689,
cbga = 0.4375,
})

AddToSolution("BS-3-15-21",{
cbd = 77.5565,
cbdv = 4.6787,
cbg = 3.4906,
cbga = 0.4892,
})
AddToSolution("BS-4-06-21",{
cbd = 90.8088,
cbg = 7.5748,
})
AddToSolution("d9disty",{

d9thc = 92.3,})


Add("d8-7-10-21",3)
Add("BSCBD",6)
PrintSolution()
