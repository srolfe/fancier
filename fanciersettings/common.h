#import <QuartzCore/QuartzCore.h>

@interface PSTextEditingCell : UITableViewCell
{
}

- (void)layoutSubviews;

@end

@interface UIKeyboardCandidateView
	+ (id)sharedInstanceForInlineView;
@end

@interface UIKeyboardLayout : UIView
	- (id)initWithFrame:(struct CGRect)arg1;
	- (void)setRenderConfig:(id)arg1;
@end

@interface UIKBRenderConfig : NSObject
	+ (id)darkConfig;
	+ (id)defaultConfig;
@end

@interface UIKeyboard : UIView
	- (void)movedFromSuperview:(id)arg1;
	- (_Bool)isActive;
	+ (id)activeKeyboard;
	- (id)initWithDefaultSize;
	- (id)initWithFrame:(struct CGRect)arg1;
	- (void)activate;
	- (void)maximize;
	- (void)setNeedsDisplay;
	- (void)updateLayout;
	+ (void)initImplementationNow;
	- (void)_setRenderConfig:(id)arg1;
@end

@interface PSListController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	UITableView *_table;
	NSArray *_specifiers;
}
	- (id)table;
	- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
	- (id)_tableView:(id)arg1 viewForCustomInSection:(long long)arg2 isHeader:(_Bool)arg3;
	- (id)_customViewForSpecifier:(id)arg1 class:(Class)arg2 isHeader:(_Bool)arg3;
	- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
	- (id)loadSpecifiersFromPlistName:(id)arg1 target:(id)arg2;
	- (id)init;
@end

@interface PSSpecifier : NSObject{
    id target;
    SEL getter;
    SEL setter;
    SEL action;
    SEL cancel;
    Class detailControllerClass;
    long long cellType;
    Class editPaneClass;
    long long keyboardType;
    long long autoCapsType;
    long long autoCorrectionType;
    unsigned long long textFieldType;
    NSString *_name;
    NSArray *_values;
    NSDictionary *_titleDict;
    NSDictionary *_shortTitleDict;
    id _userInfo;
    NSMutableDictionary *_properties;
    SEL _confirmationAction;
    SEL _confirmationCancelAction;
    SEL _buttonAction;
    SEL _controllerLoadAction;
    _Bool _showContentString;
}
	@property(retain, nonatomic) NSString *name; 
	+ (long long)keyboardTypeForString:(id)arg1;
	+ (long long)autoCapsTypeForString:(id)arg1;
	+ (long long)autoCorrectionTypeForNumber:(id)arg1;
	+ (id)emptyGroupSpecifier;
	+ (id)groupSpecifierWithName:(id)arg1;
	+ (id)preferenceSpecifierNamed:(id)arg1 target:(id)arg2 set:(SEL)arg3 get:(SEL)arg4 detail:(Class)arg5 cell:(long long)arg6 edit:(Class)arg7;
	- (id)description;
	- (void)dealloc;
	- (void)setValues:(id)arg1 titles:(id)arg2 shortTitles:(id)arg3 usingLocalizedTitleSorting:(_Bool)arg4;
	- (void)setValues:(id)arg1 titles:(id)arg2 shortTitles:(id)arg3;
	- (void)setValues:(id)arg1 titles:(id)arg2;
	- (id)properties;
	- (void)setProperties:(id)arg1;
	- (void)removePropertyForKey:(id)arg1;
	- (void)setProperty:(id)arg1 forKey:(id)arg2;
	- (id)propertyForKey:(id)arg1;
	- (id)init;
@end

	@interface PSTableCell : UITableViewCell
	{
	    id _value;
	    UIImageView *_checkedImageView;
	    _Bool _checked;
	    _Bool _shouldHideTitle;
	    NSString *_hiddenTitle;
	    int _alignment;
	    SEL _pAction;
	    id _pTarget;
	    _Bool _cellEnabled;
	    PSSpecifier *_specifier;
	    long long _type;
	    _Bool _lazyIcon;
	    _Bool _lazyIconDontUnload;
	    _Bool _lazyIconForceSynchronous;
	    NSString *_lazyIconAppID;
	    _Bool _reusedCell;
	    _Bool _isCopyable;
	    UILongPressGestureRecognizer *_longTapRecognizer;
	}

	+ (Class)cellClassForSpecifier:(id)arg1;
	+ (long long)cellStyle;
	+ (id)reuseIdentifierForSpecifier:(id)arg1;
	+ (id)reuseIdentifierForClassAndType:(long long)arg1;
	+ (id)reuseIdentifierForBasicCellTypes:(long long)arg1;
	+ (id)stringFromCellType:(long long)arg1;
	+ (long long)cellTypeFromString:(id)arg1;
	@property(retain, nonatomic) UILongPressGestureRecognizer *longTapRecognizer; // @synthesize longTapRecognizer=_longTapRecognizer;
	@property(retain, nonatomic) PSSpecifier *specifier; // @synthesize specifier=_specifier;
	- (double)textFieldOffset;
	- (void)reloadWithSpecifier:(id)arg1 animated:(_Bool)arg2;
	- (_Bool)cellEnabled;
	- (void)setCellEnabled:(_Bool)arg1;
	- (SEL)cellAction;
	- (void)setCellAction:(SEL)arg1;
	- (id)cellTarget;
	- (void)setCellTarget:(id)arg1;
	- (SEL)action;
	- (void)setAction:(SEL)arg1;
	- (id)target;
	- (void)setTarget:(id)arg1;
	- (void)setAlignment:(int)arg1;
	- (id)iconImageView;
	- (id)valueLabel;
	- (id)titleLabel;
	- (id)value;
	- (void)setValue:(id)arg1;
	- (void)setIcon:(id)arg1;
	- (_Bool)canBeChecked;
	- (_Bool)isChecked;
	- (void)setChecked:(_Bool)arg1;
	- (void)setShouldHideTitle:(_Bool)arg1;
	- (void)setTitle:(id)arg1;
	- (id)title;
	- (id)getIcon;
	- (void)forceSynchronousIconLoadOnNextIconLoad;
	- (void)cellRemovedFromView;
	- (id)blankIcon;
	- (id)getLazyIconID;
	- (id)getLazyIcon;
	- (id)_contentString;
	- (_Bool)canReload;
	- (void)setHighlighted:(_Bool)arg1 animated:(_Bool)arg2;
	- (void)setSelected:(_Bool)arg1 animated:(_Bool)arg2;
	- (id)titleTextLabel;
	- (void)setValueChangedTarget:(id)arg1 action:(SEL)arg2 specifier:(id)arg3;
	- (void)layoutSubviews;
	- (void)prepareForReuse;
	- (void)refreshCellContentsWithSpecifier:(id)arg1;
	- (_Bool)canPerformAction:(SEL)arg1 withSender:(id)arg2;
	- (void)copy:(id)arg1;
	- (id)_copyableText;
	- (void)longPressed:(id)arg1;
	- (_Bool)canBecomeFirstResponder;
	- (void)dealloc;
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;

	@end
	
	@interface PSTextView

	- (void)setCell:(id)arg1;

	@end

	@interface PSTextViewTableCell : PSTableCell
	{
	    PSTextView *_textView;
	}

	- (void)drawTitleInRect:(struct CGRect)arg1 selected:(_Bool)arg2;
	@property(retain, nonatomic) PSTextView *textView;
	- (_Bool)resignFirstResponder;
	- (_Bool)canBecomeFirstResponder;
	- (_Bool)becomeFirstResponder;
	- (void)textContentViewDidEndEditing:(id)arg1;
	- (void)_adjustTextView:(id)arg1 updateTable:(_Bool)arg2 withSpecifier:(id)arg3;
	- (void)layoutSubviews;
	- (void)cellRemovedFromView;
	- (void)textContentViewDidChange:(id)arg1;
	- (void)setValue:(id)arg1;
	- (void)dealloc;
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;

	@end
	
	
	@interface PSEditableTableCell : PSTableCell <UITextViewDelegate, UITextFieldDelegate>
	{
	    UIColor *_textColor;
	    id _delegate;
	    _Bool _forceFirstResponder;
	    _Bool _delaySpecifierRelease;
	    SEL _targetSetter;
	    id _realTarget;
	    _Bool _valueChanged;
	    _Bool _returnKeyTapped;
	    PSListController *_controllerDelegate;
	}

	+ (long long)cellStyle;
	@property(readonly, nonatomic) _Bool returnKeyTapped; // @synthesize returnKeyTapped=_returnKeyTapped;
	- (id)textField;
	- (void)setPlaceholderText:(id)arg1;
	- (void)setValue:(id)arg1;
	- (id)value;
	- (_Bool)_cellIsEditing;
	- (_Bool)isEditing;
	- (_Bool)isTextFieldEditing;
	- (_Bool)resignFirstResponder;
	- (_Bool)becomeFirstResponder;
	- (_Bool)isFirstResponder;
	- (_Bool)canResignFirstResponder;
	- (_Bool)canBecomeFirstResponder;
	- (void)layoutSubviews;
	- (void)setDelegate:(id)arg1;
	- (void)setTitle:(id)arg1;
	- (void)setCellEnabled:(_Bool)arg1;
	- (void)setValueChangedTarget:(id)arg1 action:(SEL)arg2 specifier:(id)arg3;
	- (_Bool)textFieldShouldReturn:(id)arg1;
	- (void)textFieldDidEndEditing:(id)arg1;
	- (_Bool)textFieldShouldClear:(id)arg1;
	- (void)textFieldDidBeginEditing:(id)arg1;
	- (void)_saveForExit;
	- (void)_setValueChanged;
	- (void)cellRemovedFromView;
	- (void)endEditingAndSave;
	- (void)controlChanged:(id)arg1;
	- (_Bool)canReload;
	- (void)prepareForReuse;
	- (void)refreshCellContentsWithSpecifier:(id)arg1;
	- (void)dealloc;
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;
	@end
	
	@interface UITableViewCellLayoutManagerEditable1
	{
	}

	- (void)_textValueChanged:(id)arg1;
	- (void)_textFieldEndEditingOnReturn:(id)arg1;
	- (void)_textFieldEndEditing:(id)arg1;
	- (void)_textFieldStartEditing:(id)arg1;
	- (_Bool)textFieldShouldReturn:(id)arg1;
	- (_Bool)textFieldShouldBeginEditing:(id)arg1;
	- (void)textFieldDidEndEditing:(id)arg1;
	- (void)textFieldDidBeginEditing:(id)arg1;
	- (id)editableTextFieldForCell:(id)arg1;
	- (id)detailTextLabelForCell:(id)arg1;
	- (void)layoutSubviewsOfCell:(id)arg1;
	- (double)defaultTextFieldFontSizeForCell:(id)arg1;

	@end