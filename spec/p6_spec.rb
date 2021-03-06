require 'p6/alimento'

RSpec.describe P6 do
 it "has a version number" do
   expect(P6::VERSION).not_to be nil
 end

 describe Alimento do
	before (:all) do
		@tofu = Alimento.new("Tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
		@camarones = Alimento.new("Camarones", 17.6, 1.5, 0.6, 18.0, 2.0)
		@pollo = Alimento.new("Pollo", 20.6, 0.0, 5.6, 5.7, 7.1)
		@queso = Alimento.new("Queso", 25.0 , 1.3 , 33.0 , 11.0 ,41.0)
		@lentejas = Alimento.new("Lentejas", 23.5 , 52.0 , 1.4 , 0.4 , 3.4)
		@chocolate = Alimento.new("Choccolate", 5.3 , 47.0 , 30.0 , 2.3 , 3.4)

	end

	context "Probando los getters" do
		it "El getter del nombre funciona bien" do
			expect(@tofu.nombre).to eq("Tofu")
		end

		it "Probando si los getters de proteinas, carbohidratos y lípidos" do
			expect(@tofu.proteinas).to eq(8.0)
			expect(@tofu.carbohidratos).to eq(1.9)
			expect(@tofu.lipidos).to eq(4.8)
		end

		it "Probando si los getters de GEI y terreno" do
			expect(@tofu.gei).to eq(2.0)
			expect(@tofu.terreno).to eq(2.2)
		end
	end

	context "Probando obtencion del alimento formateado y valor eergético" do
		it "El alimento formateado es correcto" do
			expect(@tofu.to_s).to eq("Tofu , 8.0 , 1.9 , 4.8 , 2.0 , 2.2" )
		end

		it "El valor energético es el correcto" do
			expect(@tofu.v_energ).to eq(82.8)
		end
	end

	context "Probando cálculo impacto ambiental" do
		it "Cálculo correcto impacto ambiental de un hombre" do
			arry_gei = [@tofu.gei ,  @camarones.gei ,  @pollo.gei ]
			arry_terreno = [@tofu.terreno , @camarones.terreno  , @pollo.terreno ]
			arry_cantidad = [8 , 10 , 12]
			expect(@tofu.imp_amb(arry_gei, arry_terreno , arry_cantidad)).to eq(387.2)
		end

		it "Cálculo correcto impacto ambiental de una mujer" do
			arry_gei = [@tofu.gei ,  @queso.gei ,  @pollo.gei ]
			arry_terreno = [@tofu.terreno , @queso.terreno  , @pollo.terreno ]
			arry_cantidad = [8 , 6 , 10]
			expect(@tofu.imp_amb(arry_gei, arry_terreno , arry_cantidad)).to eq(473.6)
		end
	end

	context "Probando módulos añadidos" do
		it "Probando <=> (Comparable), funciona correctamente" do
			expect(@tofu < @lentejas).to eq(true)
			expect(@tofu >= @queso).to eq(false)
			expect(@tofu == @tofu).to eq(true)
			expect(@pollo.between?(@tofu,@lentejas)).to eq(true)
			expect(@lentejas.clamp(@camarones,@tofu)).to eq(@tofu)
		end
	end
 end

 describe Lista do
	before(:all) do
		@tofu = Alimento.new("Tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
		@queso = Alimento.new("Queso", 25.0 , 1.3 , 33.0 , 11.0 ,41.0)
		@lentejas = Alimento.new("Lentejas", 23.5 , 52.0 , 1.4 , 0.4 , 3.4)
		@chocolate = Alimento.new("Chocolate", 5.3 , 47.0 , 30.0 , 2.3 , 3.4)
		@leche = Alimento.new("Leche" , 3.3 , 4.8 , 3.2 , 3.2 , 8.9)
		@pollo = Alimento.new("Pollo", 20.6, 0.0, 5.6, 5.7, 7.1)
		@huevo = Alimento.new("Huevos" , 13.0 , 1.1 , 11.0 , 4.2 , 5.7)
		@nuez = Alimento.new("Nuez" , 20.0 , 21.0 , 54.0 , 0.3 , 7.9)
		@carne_vaca = Alimento.new("Carne de vaca" , 21.1 , 0.0 , 3.1 , 50.0 , 164.0)
		@carne_cordero = Alimento.new("Carne de cordero" , 18.0 , 0.0 , 17.0 , 20.0 , 185.0)
		@cerveza = Alimento.new("Cerveza" , 0.5 , 3.6 , 0.0 , 0.24 , 0.22)

		@list = Lista.new(nil,nil)
		@list2 = Lista.new(nil,nil)

		@espanola = Lista.new(nil,nil)
		@vasca = Lista.new(nil,nil)
		@vegetaria = Lista.new(nil,nil)
		@vegetaliana = Lista.new(nil,nil)
		@solocarne = Lista.new(nil,nil)
	end

	context "Probando getters" do
		it "Getter de la cabeza funciona correctamente" do
			expect(@list.head).to eq(nil)
		end

		it "Getter de la cola funciona correctamente" do
			expect(@list.tail).to eq(nil)
		end

	end

	context "Probando inserción" do
		it "Insertar un elemento por la cabeza en la lista correcto" do
			expect(@list.insert_element_head(5)).to eq([5,nil,nil])
		end

		it "Insertar un elemento por la cola en la lista correcto" do
			expect(@list.insert_element_tail(7)).to eq(7)
		end

		it "Insertar varios elementos por la cabeza correcto" do
			expect(@list2.insert_all_elements_head([5,6,7])).to eq(3)
		end

		it "Insertar varios elementos por la cola correcto" do
			expect(@list2.insert_all_elements_tail([5,6])).to eq(2)
		end

	end

	context "Probando extracción" do
		it "Eliminar un elemento por la cabeza" do
			expect(@list2.erase_element_head).to eq(6)
		end

		it "Eliminar un elemento por la cola" do
			expect(@list2.erase_element_tail).to eq(5)
		end
	end

	context "Probando las dietas" do
		it "Dieta española y vasca creada correctamente" do
			expect(@espanola.insert_all_elements_head([[@lentejas,7],[@chocolate,4.05],[@queso,6.3]])).to eq(3)
			expect(@vasca.insert_all_elements_head([[@nuez,13],[@cerveza,35]])).to eq(2)
		end

		it "Dieta vegetaria y vegetaliana creada correctamente" do
			expect(@vegetaria.insert_all_elements_head([[@leche,10],[@huevo, 9],[@tofu, 6]])).to eq(3)
			expect(@vegetaliana.insert_all_elements_tail([[@lentejas,6],[@tofu,9],[@nuez,7]])).to eq(3)
		end

		it "Dieta solo carne creada correctamente" do
			expect(@solocarne.insert_all_elements_head([[@carne_cordero,5],[@carne_vaca,4],[@pollo,5]])).to eq(3)
		end
	end

	context "Expectativas para las dietas" do
		it "Expectativas para estimar las emisiones diarias de GEI" do
			expect(@espanola.expc_gei(1)).to eq(81.4)
			expect(@vasca.expc_gei(1)).to eq(12.3)
			expect(@vegetaria.expc_gei(1)).to eq(81.8)
			expect(@vegetaliana.expc_gei(1)).to eq(22.5)
			expect(@solocarne.expc_gei(1)).to eq(328.5)
		end
		
		it "Expectativas para estimar las emisiones anuales de GEI" do
			expect(@espanola.expc_gei(365)).to eq(29716.5)
			expect(@vasca.expc_gei(365)).to eq(4489.5)
			expect(@vegetaria.expc_gei(365)).to eq(29857.0)
			expect(@vegetaliana.expc_gei(365)).to eq(8212.5)
			expect(@solocarne.expc_gei(365)).to eq(119902.5)
		end

		it "Expectativas para estimar las emisiones diarias de metros cuadrados de uso de terreno" do
			expect(@espanola.expc_m2t).to eq(295.9)
			expect(@vasca.expc_m2t).to eq(110.4)
			expect(@vegetaria.expc_m2t).to eq(153.5)
			expect(@vegetaliana.expc_m2t).to eq(95.5)
			expect(@solocarne.expc_m2t).to eq(1616.5)
		end

	end

	context "Prueba modulos añadidos" do
		it "Probando collect(Enumerable), funciona correctamente" do
			expect(@vasca.collect{|x| x[0].lipidos >80}).to eq([false,false])
		end

		it "Probando select(Enumerable), funciona correctamente" do
			expect(@vasca.select{|x| x[0].lipidos >80}).to eq([])
		end

		it "Probando max(Enumerable), funciona correctamente" do
			expect(@vasca.max).to eq([@nuez,13])
		end

		it "Probando min(Enumerable), funciona correctamente" do
			expect(@vasca.min).to eq([@cerveza,35])
		end

		it "Probando sort(Enumerable), funciona correctamente" do
			expect(@vasca.sort{|a,b| a.length <=> b.length}).to eq([[@cerveza , 35],[@nuez,13]])
		end

	end
 end

 describe Plato do
	before(:all) do
		@conjunto_alim = Lista.new(nil,nil)
		@conjunto_cant = Lista.new(nil,nil)
		@tofu = Alimento.new("Tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
		@queso = Alimento.new("Queso", 25.0 , 1.3 , 33.0 , 11.0 ,41.0)
		@lentejas = Alimento.new("Lentejas", 23.5 , 52.0 , 1.4 , 0.4 , 3.4)
		@chocolate = Alimento.new("Chocolate", 5.3 , 47.0 , 30.0 , 2.3 , 3.4)
		@leche = Alimento.new("Leche" , 3.3 , 4.8 , 3.2 , 3.2 , 8.9)
		@pollo = Alimento.new("Pollo", 20.6, 0.0, 5.6, 5.7, 7.1)
		@huevo = Alimento.new("Huevos" , 13.0 , 1.1 , 11.0 , 4.2 , 5.7)
		@nuez = Alimento.new("Nuez" , 20.0 , 21.0 , 54.0 , 0.3 , 7.9)
		@carne_vaca = Alimento.new("Carne de vaca" , 21.1 , 0.0 , 3.1 , 50.0 , 164.0)
		@carne_cordero = Alimento.new("Carne de cordero" , 18.0 , 0.0 , 17.0 , 20.0 , 185.0)
		@cerveza = Alimento.new("Cerveza" , 0.5 , 3.6 , 0.0 , 0.24 , 0.22)
		
		@conjunto_alim.insert_all_elements_head([@queso, @lentejas, @chocolate])
		@conjunto_cant.insert_all_elements_head([14.0,2.5,8.0])
		@plato = Plato.new("Plato", @conjunto_alim , @conjunto_cant)
	end

	it "Obteniendo el nombre de un plato" do
		expect(@plato).to respond_to(:nombre)
	end

	it "Existe un conjunto de alimentos" do
		expect(@plato).to respond_to(:conjunto_alimentos)
	end

	it "Existe un conjunto de cantidades de alimentos en gramos" do
		expect(@plato).to respond_to(:conjunto_cantidades)
	end

	context "Comprobando los porcentajes" do
		it "Porcentaje de poteínas del conjunto de alimentos correcto" do
			expect(@plato.por_prot).to eq("1.84%")
		end

		it "Porcentaje de lípidos del conjunto de alimentos correcto" do
			expect(@plato.por_lipid).to eq("2.88%")
		end

		it "Porcentaje de hidratos de carbono del conjunto de alimentos correcto" do
			expect(@plato.por_h_carb).to eq("2.14%")
		end
	end

	it "Valor calórico del conjunto de alimentos (kcal) correcto" do
		expect(@plato.vct).to eq(9.57)
	end

	it "Plato formateado correctamente" do
		expect(@plato.to_s).to eq("Plato Chocolate -> 8.0 Lentejas -> 2.5 Queso -> 14.0 ")
	end
 end

 describe Plato_heredada do
	before(:all) do
		@conjunto_alim = Lista.new(nil,nil)
		@conjunto_cant = Lista.new(nil,nil)
		@tofu = Alimento.new("Tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
		@queso = Alimento.new("Queso", 25.0 , 1.3 , 33.0 , 11.0 ,41.0)
		@lentejas = Alimento.new("Lentejas", 23.5 , 52.0 , 1.4 , 0.4 , 3.4)
		@chocolate = Alimento.new("Chocolate", 5.3 , 47.0 , 30.0 , 2.3 , 3.4)
		@leche = Alimento.new("Leche" , 3.3 , 4.8 , 3.2 , 3.2 , 8.9)
		@pollo = Alimento.new("Pollo", 20.6, 0.0, 5.6, 5.7, 7.1)
		@huevo = Alimento.new("Huevos" , 13.0 , 1.1 , 11.0 , 4.2 , 5.7)
		@nuez = Alimento.new("Nuez" , 20.0 , 21.0 , 54.0 , 0.3 , 7.9)
		@carne_vaca = Alimento.new("Carne de vaca" , 21.1 , 0.0 , 3.1 , 50.0 , 164.0)
		@carne_cordero = Alimento.new("Carne de cordero" , 18.0 , 0.0 , 17.0 , 20.0 , 185.0)
		@cerveza = Alimento.new("Cerveza" , 0.5 , 3.6 , 0.0 , 0.24 , 0.22)
		@cerdo = Alimento.new("Cerdo" , 21.5 , 0.0 , 6.3 , 7.6 , 11.0)
		@salmon = Alimento.new("Salmón" , 19.9 , 0.0 , 13.6 , 6.0 , 3.7)

		@conjunto_alim.insert_all_elements_head([@queso, @lentejas, @chocolate])
		@conjunto_cant.insert_all_elements_head([14.0,2.5,8.0])
		@plato = Plato_heredada.new("Plato", @conjunto_alim , @conjunto_cant)

		@d_a_espanola=Lista.new(nil,nil)
		@d_a_espanola.insert_all_elements_head([@carne_vaca , @chocolate , @queso , @lentejas , @nuez])
		@d_c_espanola=Lista.new(nil,nil)
		@d_c_espanola.insert_all_elements_head([100 , 100 , 200 , 100 , 200])
		@plato_espanol = Plato_heredada.new("Espanola" , @d_a_espanola , @d_c_espanola)

		@d_a_vasca=Lista.new(nil,nil)
		@d_a_vasca.insert_all_elements_head([@lentejas , @chocolate , @nuez])
		@d_c_vasca=Lista.new(nil,nil)
		@d_c_vasca.insert_all_elements_head([600 , 200 , 100])
		@plato_vasco = Plato_heredada.new("Vasco" , @d_a_vasca , @d_c_vasca)

		@d_a_vegetaria=Lista.new(nil,nil)
		@d_a_vegetaria.insert_all_elements_head([@huevo , @chocolate , @queso , @lentejas , @nuez])
		@d_c_vegetaria=Lista.new(nil,nil)
		@d_c_vegetaria.insert_all_elements_head([100 , 100 , 200 , 100 , 200])
		@plato_vegetaria = Plato_heredada.new("Vegetaria" , @d_a_vegetaria , @d_c_vegetaria)

		@d_a_vegetaliana=Lista.new(nil,nil)
		@d_a_vegetaliana.insert_all_elements_head([@tofu , @chocolate , @nuez , @lentejas])
		@d_c_vegetaliana=Lista.new(nil,nil)
		@d_c_vegetaliana.insert_all_elements_head([100 , 100 , 300 , 200])
		@plato_vegetaliana = Plato_heredada.new("Vegetaliana" , @d_a_vegetaliana , @d_c_vegetaliana)

		@d_a_locura_carne=Lista.new(nil,nil)
		@d_a_locura_carne.insert_all_elements_head([@carne_vaca , @carne_cordero , @pollo , @cerdo , @nuez , @salmon])
		@d_c_locura_carne=Lista.new(nil,nil)
		@d_c_locura_carne.insert_all_elements_head([200 , 300 , 200 , 200 , 200 , 100])
		@plato_locura_carne = Plato_heredada.new("Locura carne" , @d_a_locura_carne , @d_c_locura_carne)
		@menu = Lista.new(nil,nil)
		@menu.insert_all_elements_head([@plato_espanol , @plato_vasco , @plato_vegetaria , @plato_vegetaliana , @plato_locura_carne])

	end

	it "Valor total del gei correcto" do
		expect(@plato.t_gei).to eq(0.17)
	end

	it "Valor total de terreno correcto" do
		expect(@plato.t_terreno).to eq(0.61)
	end

	it "Eficiencia energética formateada correcta" do
		expect(@plato.to_s).to eq("Plato Chocolate -> 2.3 , 3.4 Lentejas -> 0.4 , 3.4 Queso -> 11.0 , 41.0 ")
	end

	context "Probando instancias de objetos" do
		it "Clase del objeto correcta " do
			expect(@plato.instance_of? Plato_heredada).to eq(true)
		end

		it "La clase padre de Plato_heredada es Plato" do
			expect(Plato_heredada.superclass).to eq(Plato)
		end

		it "La clase plato_heredada está en la jerarquía de Plato" do
			expect(@plato.is_a?Plato).to eq(true)
		end
	end

	context "Probando comparable con las distintas dietas" do
		it " El operador < funciona correctamente" do
			expect(@plato_espanol < @plato_vasco).to eq(false)
		end

		it " El operador >= funciona correctamente" do
			expect(@plato_vasco >= @plato_vegetaliana).to eq(true)
		end

		it " El operador == funciona correctamente" do
			expect(@plato_locura_carne == @plato_locura_carne).to eq(true)
		end

	#	it " El operador <= funciona correctamente" do
	#		expect(@plato_locura_carne <= @plato_vasco).to eq(true)
	#	end

	#	it " El operador between funciona correctamente" do
	#		expect(@plato_espanol.between?(@plato_vasco,@plato_vegetaria)).to eq(true)
	#	end

	#	it " El operador clamp funciona correctamente" do
	#		expect(@plato_locura_carne.clamp(@plato_vasco,@plato_espanol)).to eq(@plato_vasco)
	#	end
	end

	context "Prueba dieta española" do
		it "Probando collect(Enumerable), funciona correctamente" do
			expect(@menu.collect{|x| x.vct < 3000}).to eq([true,true,true,true,true])
		end

		it "Probando select(Enumerable), funciona correctamente" do
			expect(@menu.select{|x| x.vct > 3000}).to eq([])
		end

	#	it "Probando max(Enumerable), funciona correctamente" do
	#		expect(@menu.max).to eq(@plato_espanol)
	#	end

		it "Probando min(Enumerable), funciona correctamente" do
			expect(@menu.min).to eq(@plato_vasco)
		end

	#	it "Probando sort(Enumerable), funciona correctamente" do
	#		expect(@menu.sort{|a,b| a <=> b}).to eq([@plato_locura_carne , @plato_espanol , @plato_vegetaliana , @plato_vegetaria , @plato_vasco])
	#	end

	end
 end

describe Plato_heredada do
	before(:all) do
		
		@alim1 = Alimento.new("carne_de_vaca", 21.1, 0.0, 3.1, 50.0, 164.0)
		@alim2 = Alimento.new("chocolate", 5.3, 47.0, 30.0, 2.3, 3.4)
		@alim3 = Alimento.new("lentejas", 23.5, 52.0, 1.4, 0.4, 3.4)
		@alim4 = Alimento.new("huevos", 13.0, 1.1, 11.0, 4.2, 5.7)
		@alim5 = Alimento.new("cerveza", 0.5, 3.6, 0.0, 0.24, 0.22)
		@alim6 = Alimento.new("leche_de_vaca", 3.3, 4.8, 3.2, 3.2, 8.9)
		@alim7 = Alimento.new("café", 0.1, 0.0, 0.0, 0.4, 0.3)
		@alim8 = Alimento.new("tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
		@alim9 = Alimento.new("nuez", 20.0, 21.0, 54.0, 0.3, 7.9)
		@alim10 = Alimento.new("carne_de_cordero", 18.9, 0.0, 17.0, 20, 185.0)
		@alim11 = Alimento.new("queso", 25.0, 1.3, 33.0, 11.0, 41.0)
		@alim12 = Alimento.new("pollo", 20.6, 0.0, 5.6, 5.7, 7.1)

		@listac = Lista.new(nil,nil)
		@listae = Lista.new(nil,nil)
		@listav = Lista.new(nil,nil)
		@listavegr = Lista.new(nil,nil)
		@listavegl = Lista.new(nil,nil)

		@listav_c = Lista.new(nil,nil)
		@listae_c = Lista.new(nil,nil)
		@listac_c = Lista.new(nil,nil)
		@listavegr_c = Lista.new(nil,nil)
		@listavegl_c = Lista.new(nil,nil)

		@listac.insert_all_elements_head( [ @alim1,@alim10,@alim11,@alim12,@alim5 ])
		@listae.insert_all_elements_head( [ @alim3,@alim5,@alim9 ])
		@listav.insert_all_elements_head( [ @alim1,@alim3,@alim2,@alim5,@alim7 ])
		@listavegr.insert_all_elements_head( [ @alim8,@alim4,@alim3,@alim9,@alim5 ])
		@listavegl.insert_all_elements_head( [ @alim8,@alim3,@alim9,@alim5 ])

		@listav_c.insert_all_elements_head([4,2,4,2,1])
		@listae_c.insert_all_elements_head([15,3,8])
		@listac_c.insert_all_elements_head([15,7,5,3.5,4])
		@listavegr_c.insert_all_elements_head( [2,5,2.5,3.5,8])

		@plato1 = Plato.new("Plato de carne",@listac,@listac_c)
		@plato2 = Plato.new("Plato español",@listae,@listae_c)
		@plato3 = Plato.new("Plato vasco",@listav,@listav_c)
		@plato4 = Plato.new("Plato vegetariano",@listavegr,@listavegr_c)
		@plato5 = Plato.new("Plato vegetaliano",@listavegl, @listavegl_c)
	
		@menu1 = [@plato1,@plato2,@plato4]
		@precio1 = [25,10,32]

		@menu2 = [@plato1,@plato4,@plato3]
		@precio2 = [10,20,15]
	end
	
	it "Huella nutricional" do
		expect(@plato1.huella_nutricional).to eq(1.6)
		expect(@plato2.huella_nutricional).to eq(1.67)
		expect(@plato3.huella_nutricional).to eq(1.2)
		expect(@plato4.huella_nutricional).to eq(1.4)
	end

	it "Plato con mayor huella nutricional menú" do
		expect(@menu1.max).to eq(@plato2)
	end

	it "Comprobando lista de precios" do
		expect(precio(@menu1,@precio1)).to eq([40.0,16.0,51.2])
	end
end

end
