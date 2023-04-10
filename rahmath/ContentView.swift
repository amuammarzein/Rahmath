//
//  TutorialView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 28/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var arr_element:[modelElement] = []
    @State private var arr_actor_selected:[modelActor] = [
      modelActor(),
      modelActor(),
      modelActor(),
    ]
    @State private var question = ""
    @State private var random_index = 0
    @State private var value_target = 0
    @State private var total_element = 0
    @State private var bil_1 = 0
    @State private var bil_2 = 0
    @State private var operatorr = "+"
    @State private var result = 0
    @State private var img_1 = "default"
    @State private var img_2 = "default"
    @State private var img_3 = "default"
    var x_target_min = 130;
    var x_target_max = 260;
    var y_target_min = 510;
    var y_target_max = 615;
    @State private var arr_word_addition:[modelWord] = [
        modelWord(word:"membeli",conjunction: "dari"),
        modelWord(word:"meminta",conjunction: "kepada"),
        modelWord(word:"diberi",conjunction: "oleh"),
    ]
    @State private var arr_object:[modelObject] = [
        modelObject(name:"motor",img: "element_motor"),
        modelObject(name:"apel",img: "element_apple"),
        modelObject(name:"pisang",img: "element_banana"),
        modelObject(name:"jeruk",img: "element_orange"),
        modelObject(name:"strawberry",img: "element_strawberry"),
        modelObject(name:"balon",img: "element_balloon"),
        modelObject(name:"ikan",img: "element_fish"),
        modelObject(name:"mobil",img: "element_racing_car"),
        modelObject(name:"bunga",img: "element_rose"),
        modelObject(name:"bunga",img: "element_sunflower"),
        modelObject(name:"bola",img: "element_ball"),
    ]
    @State private var arr_actor:[modelActor] = [
        modelActor(name:"Aang",img_1: "1-1",img_2: "1-2",img_3: "1-3"),
        modelActor(name:"Ashadi",img_1: "2-1",img_2: "2-2",img_3: "2-3"),
        modelActor(name:"Billbert",img_1: "3-1",img_2: "3-2",img_3: "3-3"),
        modelActor(name:"Ruci",img_1: "4-1",img_2: "4-2",img_3: "4-3"),
        modelActor(name:"Yaya",img_1: "5-1",img_2: "5-2",img_3: "5-3"),
    ]
    
    @State private var object_selected = modelObject()
    
    
    
    
   
    
    func dragElement(index:Int) -> some Gesture {
        DragGesture()
            .onChanged { value in
                self.arr_element[index].location = value.location
                self.arr_element[index].isDragging = true
                
                
                
                print("Element #",(index+1))
                print("x : ",value.location.x)
                print("y : ",value.location.y)
                
         
                if((Int(value.location.x) >= x_target_min && Int(value.location.x) <= x_target_max) && (Int(value.location.y) >= y_target_min && Int(value.location.y) <= y_target_max)){
                    arr_element[index].status = true;
                }else{
                    arr_element[index].status = false;
                }
                
                var total = 0
                arr_element.forEach { result in
                    if(result.status==true){
                        total = total + 1
                    }
                }
                value_target = total;
                
                if(value_target == total_element){
                    img_1 = arr_actor_selected[0].img_3
                    img_2 = arr_actor_selected[1].img_3
                    img_3 = arr_actor_selected[2].img_3
                }else{
                    img_1 = arr_actor_selected[0].img_1
                    img_2 = arr_actor_selected[1].img_1
                    img_3 = arr_actor_selected[2].img_1
                }
            
                
                
            }
            .onEnded {_ in self.arr_element[index].isDragging = false
                
        }
        
    }
    
 
    func play(){
        print("Play Music!")
    }
    
    func generateElement(){
        play()
        arr_element.removeAll()
        let today = Date.now
        let date = DateFormatter()
        date.dateFormat = "HH:mm:ss E, d MMM y"
        bil_1 = Int.random(in: 1..<5);
        bil_2 = Int.random(in: 1..<5);
        let operatorr = "+";
        print(date.string(from: today))
        print("Bil 1 : ",bil_1);
        print("Bil 2 : ",bil_2);
        print("Operator : ",operatorr);
        if(operatorr=="+"){
            result = Int(bil_1) + Int(bil_2);
            total_element = Int(bil_1) + Int(bil_2);
        }
        print("Result : ",result);
        
        var index = 0
        
        var x = 100
        var y = 280
        for i in 0...(bil_1-1) {
            arr_element.append(modelElement(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
            x += 10
            y += 10
            index = index + 1;
        }
        
        x = 300
        y = 280
        for i in 0...(bil_2-1) {
            arr_element.append(modelElement(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
            x += 10
            y += 10
            index = index + 1;
        }

        reset()
        
        random_index = Int.random(in: 0..<arr_actor.count);
        arr_actor_selected[0] = arr_actor[random_index]
        
        random_index = Int.random(in: 0..<arr_object.count);
        object_selected = arr_object[random_index]
        
        random_index = Int.random(in: 0..<arr_word_addition.count);
        var word_selected = arr_word_addition[random_index]
        
        
        for i in 0...10 {
            random_index = Int.random(in: 1..<arr_actor.count);
            if(arr_actor_selected[0].id != arr_actor[random_index].id){
                arr_actor_selected[1] = arr_actor[random_index]
                break
            }
        }
        
        for i in 0...10 {
            random_index = Int.random(in: 1..<arr_actor.count);
            if(arr_actor_selected[0].id != arr_actor[random_index].id && arr_actor_selected[1].id != arr_actor[random_index].id){
                arr_actor_selected[2] = arr_actor[random_index]
                break
            }
        }
   
        img_1 = arr_actor_selected[0].img_1
        img_2 = arr_actor_selected[1].img_1
        img_3 = arr_actor_selected[2].img_1
        
        question = arr_actor_selected[0].name+" "+word_selected.word+" "+String(bil_1)+" "+object_selected.name+" "+word_selected.conjunction+" "+arr_actor_selected[1].name+". Kemudian "+arr_actor_selected[0].name+" "+word_selected.word+" lagi "+String(bil_2)+" "+object_selected.name+" "+word_selected.conjunction+" "+arr_actor_selected[2].name+". Berapa "+object_selected.name+" yang dimiliki "+arr_actor_selected[0].name+" sekarang?"
        
        
    }
    
    func reset(){
        value_target = 0
        img_1 = "default"
        img_2 = "default"
        img_3 = "default"
    }
  
   
    struct modelElement:Identifiable{
        var id:Int = 0
        var x:Int = 0
        var y:Int = 0
        var location: CGPoint = CGPoint(x: 0, y: 0)
        var isDragging = false
        var status = false
    }
    
    struct modelObject:Identifiable{
        var id = UUID()
        var name:String = "nama object"
        var img:String = "object_default"
    }
    struct modelWord:Identifiable{
        var id = UUID()
        var word:String = ""
        var conjunction:String = ""
    }
    struct modelActor:Identifiable{
        var id = UUID()
        var name:String = ""
        var img_1:String = "default"
        var img_2:String = "default"
        var img_3:String = "default"
        var status = false
    }
    
   
    
    var body: some View {
        
        
        
        ZStack{

            LinearGradient(gradient: Gradient(colors: [Color("colorRed"), Color("colorBlue")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.vertical)
            
            
            VStack{
                Text(question).foregroundColor(Color.white)
//                    .font(.custom("SF Pro Rounded", fixedSize: 18)).fontWeight(.bold)
                    .font(Font.system(size:18,design: .rounded).weight(.heavy))
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    ).padding(.leading,20).padding(.trailing,20).padding(.top,10)
                Button {
                    generateElement()
                } label: {
                    Image(systemName: "arrowtriangle.forward.circle")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                        .offset(x: 0, y: 0)
                }
            }
            
            
            HStack{
                Text(arr_actor_selected[1].name).foregroundColor(Color.white)
                    .font(Font.system(size:18,design: .rounded).weight(.heavy))
                    .frame(width:100)
                    .offset(x: 0, y: -250)
                
                Text(arr_actor_selected[2].name).foregroundColor(Color.white)
                    .font(Font.system(size:18,design: .rounded).weight(.heavy))
                    .frame(width:100)
                    .offset(x: 90, y: -250)
            }
            
            
        
            
            
            Image(img_2)
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                            .offset(x: -100, y: -200)
            
           
            
            Image(img_3)
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                            .offset(x: 100, y: -200)
            
            
           
            
            Image(systemName:"basket")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                            .offset(x: 0, y: 200)
            
            
         
            Text(arr_actor_selected[0].name).foregroundColor(Color.white)
                .font(Font.system(size:18,design: .rounded).weight(.heavy))
                .frame(width:100)
                .offset(x: 140, y: 130)
           
            
            Image(img_1)
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                            .offset(x: 100, y: 180)
            
           
           
        
            Text(String(value_target)).foregroundColor(Color.white)
//                .font(.custom("SF Pro Rounded", fixedSize: 50)).fontWeight(.bold)
                .font(Font.system(size:60,design: .rounded).weight(.heavy))
                .offset(x: 0, y: 280)
            
          
            
       
                ForEach(arr_element, id: \.id) { result in
                    Image(object_selected.img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50).shadow(color: .black, radius: 2, x: 3, y: 3)
                        .position(result.location)
                        .gesture(dragElement(index: result.id))
                            }

           
            
            
             
            
            

            
           
                        
        }   .onAppear {
            generateElement()
         }
         
       
        
    }
}



