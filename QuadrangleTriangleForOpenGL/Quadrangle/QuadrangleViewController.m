//
//  QuadrangleViewController.m
//  QuadrangleTriangleForOpenGL
//
//  Created by tongle on 2017/8/22.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "QuadrangleViewController.h"
#import <GLKit/GLKBaseEffect.h>
#import <GLKit/GLKView.h>
#import <GLKit/GLKEffects.h>


typedef struct {
    GLfloat Positon[3];//位置
    GLfloat Color[4];//颜色
    
} Vertex;

// 顶点和颜色数组
const Vertex squareVertexData[] = {
    
    { 0.5f,  0.5f, -0.9f,  1.0f, 0.0f, 0.0f, 1.0f},  //0
    {-0.5f,  0.5f, -0.9f,  0.0f, 1.0f, 0.0f, 1.0f}, //1
    { 0.5f, -0.5f, -0.9f,  0.0f, 0.0f, 1.0f, 1.0f}, //2
    {-0.5f, -0.5f, -0.9f,  0.0f, 0.0f, 0.0f, 1.0f}  //3
    
};
// 三角形数组
const GLubyte Indices[] = {
    0, 1, 2,
    2, 1, 3
};


@interface QuadrangleViewController ()<GLKViewDelegate>
{
    EAGLContext * context;
    GLKBaseEffect * TLEffect;
}

@end

@implementation QuadrangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContext];
    [self setupVBOs];
    TLEffect = [[GLKBaseEffect alloc]init];
    TLEffect.light0.enabled = GL_TRUE;
    TLEffect.light0.diffuseColor = GLKVector4Make(0.0f, 1.0f, 0.0f, 1.0f);
    // Do any additional setup after loading the view.
}

/**
 1. 申请一个标识符
 2. 把标识符绑定到GL_ARRAY_BUFFER上
 3. 把顶点数据从cpu内存复制到gpu内存
 4. 开启对应的顶点属性
 5. 设置合适的格式从buffer里面读取数据
 */
- (void)setupVBOs{
    
    GLuint buffer;
    glGenBuffers(1, &buffer);   
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    
    GLuint elementBuffer;
    glGenBuffers(1, &elementBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, elementBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *) (sizeof(GLfloat) * 3));
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *) (sizeof(GLfloat) * 6));
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *) (sizeof(GLfloat) * 10));
}
/**
 1. 管理所有绘制的状态，命令及资源信息。
 2. 在GLKView上绘制OpenGL内容
 */

- (void)setupContext{
    
    context = [[EAGLContext alloc]initWithAPI:(kEAGLRenderingAPIOpenGLES2)];
    if (!context) {
        NSLog(@"fail...");
    }


    GLKView * glkView = [[GLKView alloc]init];
    glkView.frame = self.view.frame;
    glkView.delegate =self;
    glkView.context = context;
    glkView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:context];
    glEnable(GL_DEPTH_TEST);
    
    [self.view addSubview:glkView];

}
/**
 GLKViewDelegate
 1. 启动着色器
 2. 添加背景颜色
 3. 绘制图形
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    glClearColor(1.0, 1.0, 1.0, 1.0);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [TLEffect prepareToDraw];
    
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
