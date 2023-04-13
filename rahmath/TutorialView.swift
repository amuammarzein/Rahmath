//
//  ContentView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import SwiftUI

struct TutorialView: View {
    
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var arr_object:[modelObject] = [
        //        modelObject(name:"motorcycle",img: "element_motor"),
        //        modelObject(name:"apple",img: "element_apple"),
        //        modelObject(name:"banana",img: "element_banana"),
        //        modelObject(name:"orange",img: "element_orange"),
        //        modelObject(name:"strawberry",img: "element_strawberry"),
        //        modelObject(name:"balloon",img: "element_balloon"),
        //        modelObject(name:"fish",img: "element_fish"),
        //        modelObject(name:"car",img: "element_racing_car"),
        //        modelObject(name:"flower",img: "element_rose"),
        //        modelObject(name:"flower",img: "element_sunflower"),
        //        modelObject(name:"soccer ball",img: "element_ball"),
        modelObject(name:"apple",img: "object_apple"),
        modelObject(name:"egg",img: "object_egg"),
        modelObject(name:"pencil",img: "object_pencil"),
        modelObject(name:"donut",img: "object_donut"),
        modelObject(name:"peanut",img: "object_peanut"),
        modelObject(name:"ball",img: "object_ball"),
        modelObject(name:"avocado",img: "object_avocado"),
        modelObject(name:"cake",img: "object_cake"),
        modelObject(name:"eyeglasses",img: "object_eyeglasses"),
    ]
    @State private var object_selected = modelObject()
    @State private var arr_object_question_1:[modelObjectQuestion] = []
    @State private var arr_object_question_2:[modelObjectQuestion] = []
    @State private var arr_answer_option:[modelAnswerOption] = [
        modelAnswerOption(),
        modelAnswerOption(),
        modelAnswerOption(),
        modelAnswerOption(),
    ]
    @State private var arr_answer_selected:[modelAnswerSelected] = []
    @State private var img = "rahmath_1"
    @State private var num_1 = 0
    @State private var num_2 = 0
    @State private var op = "+"
    @State private var op_icon = "plus.circle"
    @State private var result = 0
    @State private var index = 0
    @State private var limit_question = 4
    @State private var check_answer = false
    @State private var num_question = 0
    @State private var answer_status = false
    @State private var option_selected = 0
    @State private var correct_answer = 0
    @State private var incorrect_answer = 0
    @State private var total_object = 0
    @State private var total_object_in_basket = 0
    @State private var total_object_in_box_2 = 0
    @State private var in_basket_status = false
    @State private var check_tutorial = false
    @State private var x_target_min = 100;
    @State private var x_target_max = 250;
    @State private var y_target_min = 280;
    @State private var y_target_max = 420;
    
    @State private var x_target_2_min = 200;
    @State private var x_target_2_max = 340;
    @State private var y_target_2_min = 0;
    @State private var y_target_2_max = 140;
    
    @State private var text = ""
    
    @State private var isActive = false
    
    struct modelObject:Identifiable{
        var id = UUID()
        var name:String = "nama object"
        var img:String = "object_default"
    }
    struct modelObjectQuestion:Identifiable{
        var id:Int = 0
        var x:Int = 0
        var y:Int = 0
        var location: CGPoint = CGPoint(x: 0, y: 0)
        var isDragging = false
        var status = false
        var status_minus = false
    }
    struct modelAnswerOption:Identifiable{
        var id:Int = 0
        var option:Int = 0
        var status = false
    }
    struct modelAnswerSelected:Identifiable{
        var id:Int = 0
        var option:Int = 0
        var status = false
    }
    
    
    
    
    func reset(){
        index = 0
        result = 0
        img = "rahmath_1"
        check_answer = false
        in_basket_status = false
        arr_object_question_1.removeAll()
        arr_object_question_2.removeAll()
    }
    
    func play(){
        
        getHapticsNotify(.success)
        
        total_object_in_basket = 0
        total_object_in_box_2 = 0
        
        check_tutorial = false
        num_question += 1
        reset()
        
        if(CGFloat(num_question)/CGFloat(limit_question)<=0.5){
            op = "+"
            op_icon = "plus.circle"
            num_1 = Int.random(in: 1..<5)
            num_2 = Int.random(in: 1..<5)
            total_object = num_1 + num_2
            
            result = num_1 + num_2;
            
            var x = 40
            var y = 40
            
            for i in 0...(num_1-1) {
                arr_object_question_1.append(modelObjectQuestion(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
                x += 60
                if(i > 0 && i % 2 != 0){
                    y += 60
                    x = 40
                }
                index = index + 1;
            }
            x = 45
            y = 45
            for i in 0...(num_2-1) {
                arr_object_question_2.append(modelObjectQuestion(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
                x += 60
                if(i > 0 && i % 2 != 0){
                    y += 60
                    x = 40
                }
                index = index + 1;
            }
            
        }else{
            op = "-"
            op_icon = "minus.circle"
            op_icon = "minus.circle"
            num_1 = Int.random(in: 1..<5)
            num_2 = Int.random(in: 0..<num_1)
            if(num_2==0){
                num_2 = 1
            }
            total_object = num_1
            
            result = num_1 - num_2;
            
            var x = 40
            var y = 40
            if(num_1 < 5){
                for i in 0...(num_1-1) {
                    arr_object_question_1.append(modelObjectQuestion(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if(i > 0 && i % 2 != 0){
                        y += 60
                        x = 40
                    }
                    index = index + 1;
                }
            }else{
                for i in 0...(3) {
                    arr_object_question_1.append(modelObjectQuestion(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if(i > 0 && i % 2 != 0){
                        y += 60
                        x = 40
                    }
                    index = index + 1;
                }
                x = 45
                y = 45
                for i in 4...(num_1-1) {
                    arr_object_question_1.append(modelObjectQuestion(id:index,x: x, y: y,location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if(i > 0 && i % 2 != 0){
                        y += 60
                        x = 40
                    }
                    index = index + 1;
                }
            }
            
        }
        
        
        
        print(result)
        
        
        
        
        
        
        
        index = Int.random(in: 0..<4)
        arr_answer_option[index] = modelAnswerOption(id: index,option: result)
        
        for i in 0...3 {
            if(i != index){
                for j in 0...100 {
                    var option = Int.random(in: 1..<9)
                    if(option != arr_answer_option[0].option
                       && option != arr_answer_option[1].option && option != arr_answer_option[2].option &&
                       option != arr_answer_option[3].option){
                        arr_answer_option[i] = modelAnswerOption(id: i,option: option)
                        break;
                    }
                }
            }
        }
        index = Int.random(in: 0..<arr_object.count);
        object_selected = arr_object[index]
        
        text = "Drag the "+object_selected.name+" to the basket! "
    }
    
    
    func dragElement(index:Int,que:Int) -> some Gesture {
        DragGesture()
            .onChanged { value in
                getHaptics(.soft)
                if(que == 1){
                    self.arr_object_question_1[index].location = value.location
                    self.arr_object_question_1[index].isDragging = true
                    
                    print("Object #",(index+1))
                    print("x : ",value.location.x)
                    print("y : ",value.location.y)
                    print("q : ",que)
                    print("i : ",index)
                    
                    
                    if((Int(value.location.x) >= x_target_min && Int(value.location.x) <= x_target_max) && (Int(value.location.y) >= y_target_min && Int(value.location.y) <= y_target_max)){
                        arr_object_question_1[index].status = true;
                    }else{
                        arr_object_question_1[index].status = false;
                    }
                    
                    
                }else{
                    self.arr_object_question_2[index].location = value.location
                    self.arr_object_question_2[index].isDragging = true
                    
                    print("Object #",(index+1+num_1))
                    print("x : ",value.location.x)
                    print("y : ",value.location.y)
                    print("q : ",que)
                    print("i : ",index)
                    
                    if((Int(value.location.x) >= x_target_min-200 && Int(value.location.x) <= x_target_max-200) && (Int(value.location.y) >= y_target_min && Int(value.location.y) <= y_target_max)){
                        arr_object_question_2[index].status = true;
                    }else{
                        arr_object_question_2[index].status = false;
                    }
                    
                    
                }
                
                
                
                
                
                if(op == "+"){
                    var total = 0
                    arr_object_question_1.forEach { result in
                        if(result.status==true){
                            total = total + 1
                        }
                    }
                    
                    arr_object_question_2.forEach { result in
                        if(result.status==true){
                            total = total + 1
                        }
                    }
                    
                    
                    //                        if(total == result){
                    //                            img = "rahmath_2"
                    //                        }else{
                    //                            img = "rahmath_1"
                    //                        }
                    
                    total_object_in_basket = total
                    if(total==result){
                        check_tutorial = true
                        text = "Good Job! "+String(num_1)+" + "+String(num_2)+" = "+String(result)
                    }else{
                        check_tutorial = false
                        text = "Drag the "+object_selected.name+" to the basket! "
                    }
                }else if(op == "-"){
                    var total = 0
                    arr_object_question_1.forEach { result in
                        if(result.status==true){
                            total = total + 1
                        }
                    }
                    
                    arr_object_question_2.forEach { result in
                        if(result.status==true){
                            total = total + 1
                        }
                    }
                    total_object_in_basket = total
                    
                    if(total==total_object){
                        in_basket_status = true
                    }else{
                        check_tutorial = false
                        text = "Drag the "+object_selected.name+" to the basket! "
                    }
                    if(in_basket_status==true){
                        if(que == 1){
                            self.arr_object_question_1[index].location = value.location
                            self.arr_object_question_1[index].isDragging = true
                            
                            print("Object #",(index+1))
                            print("x : ",value.location.x)
                            print("y : ",value.location.y)
                            print("q : ",que)
                            print("i : ",index)
                            
                            
                            if((Int(value.location.x) >= x_target_2_min && Int(value.location.x) <= x_target_2_max) && (Int(value.location.y) >= y_target_2_min && Int(value.location.y) <= y_target_2_max)){
                                arr_object_question_1[index].status_minus = true;
                            }else{
                                arr_object_question_1[index].status_minus = false;
                            }
                            
                        }else{
                            self.arr_object_question_2[index].location = value.location
                            self.arr_object_question_2[index].isDragging = true
                            
                            print("Object #",(index+1+num_1))
                            print("x : ",value.location.x)
                            print("y : ",value.location.y)
                            print("q : ",que)
                            print("i : ",index)
                            
                            if((Int(value.location.x) >= x_target_2_min-200 && Int(value.location.x) <= x_target_2_max-200) && (Int(value.location.y) >= y_target_2_min && Int(value.location.y) <= y_target_2_max)){
                                arr_object_question_2[index].status_minus = true;
                            }else{
                                arr_object_question_2[index].status_minus = false;
                            }
                            
                        }
                        
                        var total_2 = 0
                        arr_object_question_1.forEach { result in
                            if(result.status_minus==true){
                                total_2 += 1
                            }
                        }
                        
                        arr_object_question_2.forEach { result in
                            if(result.status_minus==true){
                                total_2 += 1
                            }
                        }
                        total_object_in_box_2 = total_2
                        
                        if(total_object_in_box_2 == num_2){
                            if(total_object_in_basket == result){
                                text = "Good Job! "+String(num_1)+" - "+String(num_2)+" = "+String(result)
                                check_tutorial = true
                            }else{
                                text = "Make sure there are no "+object_selected.name+" outside the basket!"
                                check_tutorial = false
                            }
                        }else if(total_object_in_basket == result){
                            if(total_object_in_box_2 == num_2){
                                text = "Good Job! "+String(num_1)+" - "+String(num_2)+" = "+String(result)
                                check_tutorial = true
                            }else{
                                text = "Great! Now drag "+String(num_2)+" "+object_selected.name+" to the top right box! "
                                check_tutorial = false
                            }
                        }else{
                            text = "Great! Now drag "+String(num_2)+" "+object_selected.name+" to the top right box! "
                            check_tutorial = false
                        }
                    }
                }
                
            }
            .onEnded {_ in
                if(que == 1){
                    self.arr_object_question_1[index].isDragging = false
                }else{
                    self.arr_object_question_2[index].isDragging = false
                }
                if(check_tutorial==true){
                    playSound(file_name: "correct.mp3")
                }
                
            }
        
    }
    
    @State var isPop:Bool = false
    
    var body: some View {
        NavigationStack{
            
            ZStack(alignment: .bottom){
                ZStack(){
                    Image("basket_2").resizable().scaledToFit().frame(height:200)
                }.zIndex(3).padding(.bottom,200)
                ZStack(){
                    Circle().foregroundColor(Color("colorBlue").opacity(0.9)).frame(height:40).padding(.top,70)
                    Text(String(total_object_in_basket)).font(.system(size:20,weight: .heavy)).foregroundColor(Color("colorWhite")).frame(height:60).padding(.top,70)
                }.zIndex(5).padding(.bottom,200)
                ZStack(alignment:.bottom){
                    VStack(){
                        Spacer()
                        Text(text).multilineTextAlignment(.center).font(.system(size:20,weight: .light,design: .rounded)).padding(.bottom,30).padding(.trailing,20).padding(.leading,20)
                        if(check_tutorial == true && num_question < limit_question){
                            Button(
                                action:{
                                    if(num_question < limit_question){
                                        play()
                                    }
                                }
                            ){
                                Text("Next Tutorial")
                                    .font(.system(size: 20,weight:.regular ,design: .rounded)).padding().frame(maxWidth: .infinity)
                                
                            }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                                .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.bottom,20).padding(.leading,20).padding(.trailing,20)
                        }else if(check_tutorial == true && num_question>=limit_question){
                            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                                Text("Back to Home")
                                    .font(.system(size: 20,weight:.regular ,design: .rounded)).padding().frame(maxWidth: .infinity)
                                
                            }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                                .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.bottom,20).padding(.leading,20).padding(.trailing,20)
                        }
                    }
                }.zIndex(4).padding(.leading,20).padding(.trailing,20).padding(.top,130)
                
                
                
                
                
                ZStack(){
                    HStack(alignment:.top){
                        ZStack(alignment:.top){
                            
                            ForEach(arr_object_question_1) { val in
                                Image(object_selected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:50).shadow(radius: 4,x:4,y:4).position(val.location).gesture(dragElement(index: val.id,que: 1))
                            }
                            
                        }.zIndex(1)
                        Image(systemName: op_icon).font(.system(size: 50, weight: .bold)).foregroundColor(Color("colorWhite")).padding(.top, 40).frame(width:50).opacity(0)
                        ZStack(alignment:.top){
                            
                            ForEach(arr_object_question_2) { val in
                                Image(object_selected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:50).shadow(radius: 4,x:4,y:4).position(val.location).gesture(dragElement(index: val.id - num_1,que: 2))
                            }
                        }.zIndex(1)
                        
                    }
                }.zIndex(6).padding(.leading,20).padding(.trailing,20).padding(.top,130)
                
                
                ZStack(){
                    if(check_tutorial == true){
                        ExplodingView()
                    }
                    HStack(alignment:.top){
                        ZStack(alignment:.top){
                            
                            Rectangle().frame(height:150).cornerRadius(46 ).foregroundColor(Color("colorWhite").opacity(0.3))
                            ForEach(arr_object_question_1) { val in
                                Image(object_selected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:50).position(val.location).opacity(0)
                            }
                            ZStack(){
                                Circle().foregroundColor(Color("colorBlue").opacity(0.9)).frame(height:40)
                                Text(String(num_1)).font(.system(size:20,weight: .heavy)).foregroundColor(Color("colorWhite")).frame(height:40)
                            }.offset(y:50)
                            
                        }
                        Image(systemName: op_icon).font(.system(size: 50, weight: .bold)).foregroundColor(Color("colorWhite")).padding(.top, 40).frame(width:50)
                        ZStack(alignment:.top){
                            Rectangle().frame(height:150).cornerRadius(46 ).foregroundColor(Color("colorWhite").opacity(0.3))
                            ForEach(arr_object_question_2) { val in
                                Image(object_selected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:50).position(val.location).opacity(0)
                            }
                            ZStack(){
                                Circle().foregroundColor(Color("colorBlue").opacity(0.9)).frame(height:40)
                                Text(String(num_2)).font(.system(size:20,weight: .heavy)).foregroundColor(Color("colorWhite")).frame(height:40)
                            }.offset(y:50)
                            
                        }
                        
                    }
                }.zIndex(5).padding(.leading,20).padding(.trailing,20).padding(.top,130)
                
                
                VStack(spacing:20){
                    HStack(alignment: .top){
                        Text("Tutorial #"+String(num_question)
                        ).font(.system(size: 25, weight: .bold,design: .rounded
                                      ))
                        
                        Spacer()
                        
                        
                        SettingView(isPop:$isPop)
                        
                    }
                    ZStack(alignment: .leading){
                        Rectangle().frame(height:24).cornerRadius(20).padding(.bottom,10).foregroundColor(Color("colorGrey")).opacity(0.5)
                        Rectangle().frame(width:((screenWidth-40) * (CGFloat(num_question)/CGFloat(limit_question))),height:24).cornerRadius(20).padding(.bottom,10).foregroundColor(Color("colorGreen"))
                    }
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)).frame(maxWidth: .infinity,maxHeight: .infinity).background(Color("colorBlue")).zIndex(1)
                
                Rectangle().foregroundColor(Color("colorWhite")).cornerRadius(40).frame(height:screenHeight-350).padding(.bottom,-50).zIndex(2)
                
                
                
            } .onAppear {
                play()
                
            }
        }
        
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
