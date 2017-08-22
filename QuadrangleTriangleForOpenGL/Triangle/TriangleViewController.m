//
//  TriangleViewController.m
//  QuadrangleTriangleForOpenGL
//
//  Created by tongle on 2017/8/22.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "TriangleViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>

@interface TriangleViewController ()<GLKViewDelegate>
{
    EAGLContext * context;
    GLKBaseEffect * TLEffect;
}
@end

// 顶点和颜色数组
const GLfloat Vertices[] = {
    
    -0.5, 0.5, 0.0f,      1.0f, 0.0f, 0.0f, //右下(x,y,z坐标 + rgb颜色)
    -0.5, -0.5, 0.0f,     0.0f, 1.0f, 0.0f, //左上
    0.5, -0.5, 0.0f,     0.0f, 0.0f, 1.0f, //左下
};

@implementation TriangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
   
    [self setupContext];
    [self setupVBOs];
     TLEffect = [[GLKBaseEffect alloc] init];

    // Do any additional setup after loading the view.
}

/**
   1. 管理所有绘制的状态，命令及资源信息。
   2. 在GLKView上绘制OpenGL内容
 */
- (void)setupContext{
    
    context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    [EAGLContext setCurrentContext:context];
    GLKView *view = [[GLKView alloc]init];
    view.delegate = self;
    view.frame = self.view.frame;
    view.context = context;
    
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    if (![EAGLContext setCurrentContext:context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
    [self.view addSubview:view];
}

/**
  1. GL_ARRAY_BUFFER用于顶点数组
  2. 绑定vertexBuffer到GL_ARRAY_BUFFER
  3. 给VBO传递数据
  4. 取出地址
  5. 取出颜色
  6. glVertexAttribPointer的最后一个参数是要获取的参数在GL_ARRAY_BUFFER（每一个Vertex）的偏移量
 */
- (void)setupVBOs{
    
    GLuint verticesBuffer;
    glGenBuffers(1, &verticesBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, verticesBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, (GLfloat *)NULL + 0);
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, (GLfloat *)NULL + 3);
}

/**
    GLKViewDelegate
  1. 启动着色器
  2. 添加背景颜色
  3. 绘制图形
 */
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [TLEffect prepareToDraw];
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
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
