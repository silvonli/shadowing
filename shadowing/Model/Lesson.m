//
//  Lesson.m
//  shadowing
//
//  Created by silvon on 12-12-20.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "Lesson.h"
#import "Sentence.h"
#import "../layoutConstant.h"

@interface Lesson ()


- (NSMutableAttributedString *) getAttributedTitle;
- (NSMutableAttributedString *) getAttributedSentencesWithSel:(NSArray*)selSens;
- (NSMutableAttributedString *) getAttributedNotes;
- (NSMutableAttributedString *) getAttributedTranslation;
- (NSMutableAttributedString *) genAttributedSectionTitle:(NSString *) sec;

@end

@implementation Lesson

@dynamic mp3;
@dynamic title;
@dynamic notes;
@dynamic timeStamp;
@dynamic translation;
@dynamic img;
@dynamic sentences;
@synthesize sortedSens = _sortedSens;


- (NSMutableAttributedString*) getAttributedTitle
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:self.title];
    // font
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)LESSONTITLE_FONT_NAME, LESSONTITLE_FONT_SIZE, NULL);
    [attTitle addAttribute: (NSString *)kCTFontAttributeName
                     value: (__bridge id)ctFont
                     range: NSMakeRange(0, [attTitle length])];
    CFRelease(ctFont);
    // 对齐
    CTTextAlignment alignment = kCTTextAlignmentCenter;
    CGFloat floatValue = LESSONTITLE_PARAGRAPH_SPACING;
    CGFloat fSpaceBefore = LESSONTITLE_PARAGRAPH_SPACINGBEFORE;
    CTParagraphStyleSetting paraStyles[3] =
    {
        {
            .spec = kCTParagraphStyleSpecifierAlignment,
            .valueSize = sizeof(CTTextAlignment),
            .value = &alignment
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacingBefore,
            .valueSize = sizeof(CGFloat),
            .value = &fSpaceBefore
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 3);
    [attTitle addAttribute: (NSString*)kCTParagraphStyleAttributeName
                     value: (__bridge id)aStyle
                     range: NSMakeRange(0, [attTitle length])];
    CFRelease(aStyle);
    
    [str appendAttributedString:attTitle];
    return str;
}

- (NSMutableAttributedString *) getAttributedSentencesWithSel:(NSArray*)selSens
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 句子内容字体、字号
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)SENTENCE_FONT_NAME, SENTENCE_FONT_SIZE, NULL);
    CGFloat floatValue = SENTENCE_LINE_SPACING;
    CTParagraphStyleSetting paraStyles[1] =
    {
        {
            .spec = kCTParagraphStyleSpecifierLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 1);
    
    for (Sentence* sen in self.sortedSens)
    {
        NSMutableAttributedString *subAttString = [[NSMutableAttributedString alloc] initWithString:sen.textContent];
        
        [subAttString addAttribute: (NSString *)kCTFontAttributeName
                             value: (__bridge id)ctFont
                             range: NSMakeRange(0, [subAttString length])];
        
        [subAttString addAttribute: (NSString*)kCTParagraphStyleAttributeName
                             value: (__bridge id)aStyle
                             range: NSMakeRange(0, [subAttString length])];
        
        if ([selSens containsObject:sen])
        {
            [subAttString addAttribute: (NSString*)kCTForegroundColorAttributeName
                                 value: (__bridge id)[UIColor redColor].CGColor
                                 range: NSMakeRange(0, [subAttString length])];
        }
        [str appendAttributedString:subAttString];
    }
    CFRelease(ctFont);
    CFRelease(aStyle);
    
    return str;
}

-(NSMutableAttributedString *)getAttributedNotes
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 节标题
    NSMutableAttributedString* sec = [self genAttributedSectionTitle: @"课文注释\n"];
    [str appendAttributedString:sec];
    
    // 注释
    NSMutableAttributedString *attNotes = [[NSMutableAttributedString alloc] initWithString:self.notes];
    CTFontRef notesFont = CTFontCreateWithName((CFStringRef)NOTES_FONT_NAME, NOTES_FONT_SIZE, NULL);
    [attNotes addAttribute: (NSString *)kCTFontAttributeName
                     value: (__bridge id)notesFont
                     range: NSMakeRange(0, [self.notes length])];
    CFRelease(notesFont);
    // 行间距
    CGFloat floatValue = NOTES_LINE_SPACING;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {
            .spec = kCTParagraphStyleSpecifierMaximumLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierMinimumLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 2);
    [attNotes addAttribute: (NSString*)kCTParagraphStyleAttributeName
                     value: (__bridge id)aStyle
                     range: NSMakeRange(0, [attNotes length])];
    CFRelease(aStyle);
    
    [str appendAttributedString:attNotes];
    return str;
}

- (NSMutableAttributedString *) getAttributedTranslation
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 节标题
    NSMutableAttributedString* sec = [self genAttributedSectionTitle: @"参考译文\n"];
    [str appendAttributedString:sec];
    // 译文
    NSMutableAttributedString *attTranslation = [[NSMutableAttributedString alloc] initWithString:self.translation];
    CTFontRef cfFont = CTFontCreateWithName((CFStringRef)TRANSLATION_FONT_NAME, TRANSLATION_FONT_SIZE, NULL);
    [attTranslation addAttribute: (NSString *)kCTFontAttributeName
                           value: (__bridge id)cfFont
                           range: NSMakeRange(0, [attTranslation length])];
    CFRelease(cfFont);
    
    // 行间距
    CGFloat floatValue = TRANSLATION_LINE_SPACING;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {
            .spec = kCTParagraphStyleSpecifierMaximumLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierMinimumLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 2);
    [attTranslation addAttribute: (NSString*)kCTParagraphStyleAttributeName
                           value: (__bridge id)aStyle
                           range: NSMakeRange(0, [attTranslation length])];
    CFRelease(aStyle);
    
    [str appendAttributedString:attTranslation];
    return str;
}
- (NSArray*) sortedSens
{
    if (_sortedSens != nil)
    {
        return _sortedSens;
    }
    // 按开始时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    _sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    return _sortedSens;
}

- (NSNumber*)getSelectedSentencesBeginTime:(NSInteger) index
{
    if (index<0 || index>self.sentences.count-1)
    {
        return [[self.sortedSens objectAtIndex:0] valueForKey:@"beginTime"];
    }
    else
    {
        return [[self.sortedSens objectAtIndex:index] valueForKey:@"beginTime"];
    }
}
- (NSNumber*)getSelectedSentencesEndTime:(NSInteger) index
{
    if (index<0 || index>self.sentences.count-1)
    {
         return [[self.sortedSens lastObject] valueForKey:@"endTime"];
    }
    else
    {
        return [[self.sortedSens objectAtIndex:index] valueForKey:@"endTime"];
    }
}

- (NSMutableAttributedString *) getAttributedStringWithSelSens:(NSArray*)selSens
{
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[self getAttributedTitle]];
    [attString appendAttributedString:[self getAttributedSentencesWithSel:selSens]];
    [attString appendAttributedString:[self getAttributedNotes]];
    [attString appendAttributedString:[self getAttributedTranslation]];
    return attString;
}

- (NSMutableAttributedString *) genAttributedSectionTitle:(NSString *) sec
{
    NSMutableAttributedString* attSec = [[NSMutableAttributedString alloc] initWithString:sec];
    CTFontRef secFont = CTFontCreateWithName((CFStringRef)SECTITLE_FONT_NAME, SECTITLE_FONT_SIZE, NULL);
    [attSec addAttribute: (NSString *)kCTFontAttributeName
                   value: (__bridge id)secFont
                   range: NSMakeRange(0, [attSec length])];
    CFRelease(secFont);
    CGFloat floatValue = SECTITLE_PARAGRAPH_SPACING;
    CGFloat fSpaceBefore = SECTITLE_PARAGRAPH_SPACINGBEFORE;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacingBefore,
            .valueSize = sizeof(CGFloat),
            .value = &fSpaceBefore
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 2);
    [attSec addAttribute: (NSString*)kCTParagraphStyleAttributeName
                   value: (__bridge id)aStyle
                   range: NSMakeRange(0, [attSec length])];
    CFRelease(aStyle);
    return attSec;
}

@end
